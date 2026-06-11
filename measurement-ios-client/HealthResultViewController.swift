//
//  HealthResultViewController.swift
//  measurementSDK_Example
//
//  Created by DCK on 2025/12/1.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import MeasurementSDK
class HealthResultViewController: BaseViewController {
    let result: ReportResult   // 外部传入的 Report
    
    private var hostingController: UIHostingController<HealthResultView>!
    
    init(result: ReportResult) {
        self.result = result
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    // MARK: - 导航返回方法
    /// 统一返回逻辑（适配 push/present 场景）
    @objc override func backAction() {
        if navigationController?.viewControllers.count ?? 0 > 1 {
            // 场景1：push 跳转 → pop 返回上一级
            navigationController?.popToRootViewController(animated: true)
        } else {
            // 场景2：present 跳转 → dismiss 关闭当前页面
            dismiss(animated: true, completion: nil)
        }
    }
    
    
    private func setupUI() {
        // 设置背景颜色（可选）
        view.backgroundColor = .systemBackground
        // 创建 SwiftUI View
        let healthView = HealthResultView(
            result: result,
            onSelectItem: { [weak self] item, levelValue in
                self?.pushReportDetail(item: item, levelValue: levelValue)
            }
        )
        // 包装成 HostingController
        hostingController = UIHostingController(rootView: healthView)
        
        // 添加到 UIKit Controller
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        // AutoLayout 约束（占满屏幕）
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        hostingController.didMove(toParent: self)
        // 设置导航标题（可选）
        self.title = "健康分析"
    }
    
    
    // MARK: - UIKit Push（唯一入口）
    private func pushReportDetail(
        item: ReportItem,
        levelValue: (Color, String)
    ) {
        let vc = ReportAnalysisViewController()
        vc.updateReport(
            title: item.label,
            fatigueScore: item.score,
            fatigueLevelText: levelValue.1,
            chartData: [0, 0, 0],
            chartGradient: [levelValue.0, .white],
            explanationText: item.explanation,
            adviceText: item.advice,
            fatigueColor: levelValue.0
        )
        navigationController?.pushViewController(vc, animated: true)
    }
}





