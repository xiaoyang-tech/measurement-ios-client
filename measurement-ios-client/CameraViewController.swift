// Copyright 2024 Xiaoyang Health Technology
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import AVFoundation
import MeasurementSDK
import UIKit

/// Handles the camera preview and measurement lifecycle: initialization, video frame processing,
/// and navigation to the health result screen.
class CameraViewController: BaseViewController {

    // MARK: - State

    private var cachedGuideFrame: CGRect = .zero
    private var cachedPreviewSize: CGSize = .zero
    private var isSessionRunning = false

    /// Aligned with `MeasurementConfig.measurementDuration` so the UI countdown
    /// does not finish before the SDK.
    private var measurementDurationSeconds = 15

    // MARK: - UI Outlets

    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var cameraUnavailableLabel: UILabel!
    @IBOutlet weak var resumeButton: UIButton!
    @IBOutlet weak var overlayView: OverlayView!

    private var measurementOverlay: MeasurementOverlayView!

    // MARK: - Services

    lazy var measureSDK: MeasurementManager = {
        return MeasurementManager()
    }()

    private lazy var cameraFeedService = CameraFeedService(previewView: previewView)
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraFeedService.delegate = self
        measurementOverlay = MeasurementOverlayView(frame: view.bounds)
        view.addSubview(measurementOverlay)
        initSDK()
        measurementOverlay.startMeasurement(totalSeconds: measurementDurationSeconds)
        measurementOverlay.countdownCompleted = { [weak self] in
            self?.measureSDK.start()
        }
        measurementOverlay.completeMeasurement = { [weak self] in
            DispatchQueue.main.async {
                self?.showAnalyzingOverlay()
            }
        }
    }

#if !targetEnvironment(simulator)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraFeedService.startLiveCameraSession { [weak self] cameraConfiguration in
            DispatchQueue.main.async {
                switch cameraConfiguration {
                case .failed:
                    self?.presentVideoConfigurationErrorAlert()
                case .permissionDenied:
                    self?.presentCameraPermissionsDeniedAlert()
                default:
                    break
                }
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cameraFeedService.stopSession()
    }
#endif

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cameraFeedService.updateVideoPreviewLayer(toFrame: previewView.bounds)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        cameraFeedService.updateVideoPreviewLayer(toFrame: previewView.bounds)
    }

    // MARK: - SDK Initialization

    private func initSDK() {
        measureSDK.measurementProtocol = self
        let config = MeasurementConfig(
            appId: "YOUR_APP_ID",
            sdkKey: "YOUR_SDK_KEY"
        )
        config.measurementCategories = [.all]
        config.measurementDuration = measurementDurationSeconds
        measureSDK.setMeasurement(config: config)
    }

    // MARK: - Navigation

    private func showAnalyzingOverlay() {
        let alert = UIAlertController(
            title: nil,
            message: "正在分析结果…",
            preferredStyle: .alert
        )
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.startAnimating()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        alert.view.addSubview(indicator)
        NSLayoutConstraint.activate([
            indicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor),
            indicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20)
        ])
        present(alert, animated: true)
    }

    private func pushHealthResultViewController(report: Report) {
        dismiss(animated: true) // dismiss the analyzing overlay
        let reportResult = ReportResult(report: report)
        let vc = HealthResultViewController(result: reportResult)
        vc.title = "健康报告结果"
        navigationController?.pushViewController(vc, animated: true)
    }

    private func showMeasurementFailureAlert(message: String) {
        let alertController = UIAlertController(
            title: "测量失败",
            message: message,
            preferredStyle: .alert
        )
        let confirmAction = UIAlertAction(title: "重新测量", style: .default) { [weak self] _ in
            guard let self = self, let nav = self.navigationController else { return }
            if let targetVC = nav.viewControllers.first(where: { $0 is GuideViewController }) {
                nav.popToViewController(targetVC, animated: true)
            } else {
                nav.popToRootViewController(animated: true)
            }
        }
        alertController.addAction(confirmAction)
        present(alertController, animated: true)
    }
    
    // Resume camera session when click button resume
    @IBAction func onClickResume(_ sender: Any) {
        cameraFeedService.resumeInterruptedSession {[weak self] isSessionRunning in
            if isSessionRunning {
                self?.resumeButton.isHidden = true
                self?.cameraUnavailableLabel.isHidden = true
            }
        }
    }

    
    private func presentCameraPermissionsDeniedAlert() {
        let alertController = UIAlertController(
            title: "Camera Permissions Denied",
            message:
                "Camera permissions have been denied for this app. You can change this by going to Settings",
            preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let settingsAction = UIAlertAction(title: "Settings", style: .default) { (action) in
            UIApplication.shared.open(
                URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        }
        alertController.addAction(cancelAction)
        alertController.addAction(settingsAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func presentVideoConfigurationErrorAlert() {
        let alert = UIAlertController(
            title: "Camera Configuration Failed",
            message: "There was an error while configuring camera.",
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cachedGuideFrame = measurementOverlay.scanningFrameView.frame
        cachedPreviewSize = measurementOverlay.bounds.size
    }
}

extension CameraViewController: CameraFeedServiceDelegate {
    
    func didOutput(sampleBuffer: CMSampleBuffer, orientation: UIImage.Orientation) {
        self.measureSDK.enqueue(
            sampleBuffer: sampleBuffer,
            orientation: orientation,
            guideRect: self.cachedGuideFrame,
            previewSize: cachedPreviewSize
        )
    }
    
    // MARK: Session Handling Alerts
    func sessionWasInterrupted(canResumeManually resumeManually: Bool) {
        // Updates the UI when session is interupted.
        if resumeManually {
            resumeButton.isHidden = false
        } else {
            cameraUnavailableLabel.isHidden = false
        }
    }
    
    func sessionInterruptionEnded() {
        // Updates UI once session interruption has ended.
        cameraUnavailableLabel.isHidden = true
        resumeButton.isHidden = true
    }
    
    func didEncounterSessionRuntimeError() {
        // Handles session run time error by updating the UI and providing a button if session can be
        // manually resumed.
        resumeButton.isHidden = false
    }
}


// MARK: - MeasurementProtocol

extension CameraViewController: MeasurementProtocol {

    func onStarted(measurementId: String) {
        print("Measurement started: \(measurementId)")
    }

    func onStateUpdate(code: Int, message: String) {
        DispatchQueue.main.async {
            self.measurementOverlay.updateTips(tip: message)
        }
    }

    func onInterrupted(reason: String) {
        DispatchQueue.main.async {
            self.measurementOverlay.updateTips(tip: reason)
            self.measurementOverlay.stopMeasurement()
            self.showMeasurementFailureAlert(message: reason)
        }
    }

    func onCollected() {
        print("Data collection completed.")
    }

    func onChunkReportGenerated(measurementId: String, hrReport: HrReport) {
        DispatchQueue.main.async {
            self.measurementOverlay.updateHeartRate(to: "\(Int(hrReport.data_p.hrBpm))")
        }
    }

    func onWholeReportGenerated(measurementId: String, report: Report) {
        DispatchQueue.main.async {
            self.pushHealthResultViewController(report: report)
        }
    }

    func onCrashed(code: Int, message: String) {
        print("Measurement crashed: [\(code)] \(message)")
        DispatchQueue.main.async {
            self.measureSDK.stop()
            self.measurementOverlay.stopMeasurement()
            self.showMeasurementFailureAlert(message: message)
        }
    }
}

