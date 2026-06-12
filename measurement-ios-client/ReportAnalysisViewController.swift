//
//  ReportAnalysisViewController.swift
//  measurementSDK_Example
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI


class ReportAnalysisViewController: BaseViewController {
    
    // MARK: - 属性
    private var hostingController: UIHostingController<FatigueReportView>?
    
    // 这里可以提供外部接口，让外部传入报告数据
    var titleName:String = ""
    var fatigueScore: Double = 0
    var fatigueLevelText: String = ""
    var chartData: [Double] = []
    var chartGradient: [Color] = [Color.red.opacity(0.8), Color.orange.opacity(0.2)]
    var explanationText: String = ""
    var adviceText: String = ""
    var fatigueColor: Color = Good_color

    // MARK: - 生命周期
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    // MARK: - UI设置
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        // 创建 SwiftUI 视图，将所有参数从属性传入
        let swiftUIView = FatigueReportView(
            title: titleName,
            fatigueScore: fatigueScore,
            fatigueLevelText: fatigueLevelText,
            chartData: chartData,
            chartGradient: chartGradient,
            explanationText: explanationText,
            adviceText: adviceText,
            fatigueColor:fatigueColor
        )
        
        // 创建 UIHostingController 包装 SwiftUI 视图
        hostingController = UIHostingController(rootView: swiftUIView)
        guard let hostingController = hostingController else { return }
        
        addChild(hostingController)
        view.addSubview(hostingController.view)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        hostingController.didMove(toParent: self)
    }
    
    // MARK: - 导航栏设置
    private func setupNavigation() {
        navigationItem.title = "疲劳分析"
    }
    
    // MARK: - 对外接口（更新数据）
    func updateReport(
        title:String,
        fatigueScore: Double,
        fatigueLevelText: String,
        chartData: [Double],
        chartGradient: [Color],
        explanationText: String,
        adviceText: String,
        fatigueColor:Color,
    ) {
        self.fatigueScore = fatigueScore
        self.fatigueLevelText = fatigueLevelText
        self.chartData = chartData
        self.chartGradient = chartGradient
        self.explanationText = explanationText
        self.adviceText = adviceText
        self.fatigueColor = fatigueColor
        self.titleName = title
        hostingController?.rootView = FatigueReportView(
            title: title,
            fatigueScore: fatigueScore,
            fatigueLevelText: fatigueLevelText,
            chartData: chartData,
            chartGradient: chartGradient,
            explanationText: explanationText,
            adviceText: adviceText,
            fatigueColor:fatigueColor
        )
    }
}
