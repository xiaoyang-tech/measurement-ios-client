//
//  GuideViewController.swift
//  measurement-ios-client
//
//  Copyright © 2024 Xiaoyang Health Technology. All rights reserved.
//

import Foundation
import SwiftUI
import AVFoundation
import Network

class GuideViewController: UIViewController {

    // MARK: - Constants

    private struct Constants {
        static let cameraViewControllerStoryBoardId = "CAMERA_VIEW_CONTROLLER"
        static let storyBoardName = "Main"
    }

    // MARK: - Properties

    private var hostingVC: UIHostingController<MaskView>!
    private var cameraViewController: CameraViewController?

    private var showMask = false {
        didSet { updateSwiftUIView() }
    }
    private var isLoading = false {
        didSet { updateSwiftUIView() }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        hostingVC = UIHostingController(rootView: makeSwiftUIView())
        addChild(hostingVC)
        view.addSubview(hostingVC.view)
        hostingVC.didMove(toParent: self)

        hostingVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingVC.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        showMask = true
        requestPermissionsIfNeeded()
    }

    // MARK: - SwiftUI Bridge

    private func makeSwiftUIView() -> MaskView {
        return MaskView(
            isPresented: Binding(
                get: { self.showMask },
                set: { self.showMask = $0 }
            ),
            isLoading: isLoading,
            onStart: { [weak self] in
                self?.handleStartMeasurement()
            }
        )
    }

    private func updateSwiftUIView() {
        hostingVC.rootView = makeSwiftUIView()
    }

    // MARK: - Actions

    private var isPushingCameraVC = false

    private func handleStartMeasurement() {
        guard !isPushingCameraVC else { return }
        isPushingCameraVC = true

        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }
            self.isLoading = false
            guard let cameraVC = self.instantiateCameraViewController() else { return }
            self.navigationController?.pushViewController(cameraVC, animated: true)
            self.isPushingCameraVC = false
        }
    }

    // MARK: - Navigation

    private func instantiateCameraViewController() -> CameraViewController? {
        guard let viewController = UIStoryboard(
            name: Constants.storyBoardName, bundle: .main)
            .instantiateViewController(
                withIdentifier: Constants.cameraViewControllerStoryBoardId) as? CameraViewController else {
            return nil
        }
        cameraViewController = viewController
        return cameraViewController
    }

    // MARK: - Permissions

    private func requestPermissionsIfNeeded() {
        requestCameraPermission()
        checkNetworkConnectivity()
    }

    private func requestCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                print(granted ? "Camera permission granted." : "Camera permission denied.")
            }
        case .restricted, .denied:
            print("Camera permission denied or restricted.")
        case .authorized:
            print("Camera permission already authorized.")
        @unknown default:
            break
        }
    }

    private func checkNetworkConnectivity() {
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            print(path.status == .satisfied ? "Network available." : "Network unavailable.")
            monitor.cancel()
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }
}
