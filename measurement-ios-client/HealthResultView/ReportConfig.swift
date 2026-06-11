//
//  Constant_color.swift
//  measurementSDK_Example
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI
import MeasurementSDK


// MARK: - 数据模型
struct ReportSegment {
    let min: Double
    let max: Double
    let symbol: String
    let total: Double
    let color: Color
    let label: String
}

struct ReportItem {
    let label: String
    let value: String
    let score: Double
    let category: Int
    let id: Int
    let data: [ReportSegment]
    let trend: String
    let explanation: String
    let advice: String
    let status: String
    let terms: String
}


struct ReportResult {
    var items: [ReportItem]
}

// MARK: - 颜色定义
let Excellent_color = Color(hex: "#6EDAA9")
let Good_color = Color(hex: "#85c9fa")
let Mild_unhealthiness_color = Color(hex: "#FCCE57")
let Moderately_unhealthy_color = Color(hex: "#FC9557")
let Severe_unhealthiness_color = Color(hex: "#FF5252")

///// 标题栏分割线颜色
let speratorLineHor_color = Color(red: 0.336, green: 0.482, blue: 0.755)


// MARK: - 完整数据
let reportConfig: [ReportItem] = [
    ReportItem(
        label: "综合心健康风险",
        value: "score",
        score: 0,
        category: 0,
        id: 0,
        data: [
            ReportSegment(min: 0, max: 60, symbol: "lt", total: 100, color: Severe_unhealthiness_color, label: "重度不健康"),
            ReportSegment(min: 60, max: 70, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 70, max: 80, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 80, max: 90, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 90, max: 100, symbol: "le", total: 100, color: Excellent_color, label: "优秀")
        ],
        trend: "score",
        explanation: "",
        advice: "score",
        status: "status",
        terms: "HappyCat.Term.Physiology.Score"
    ),
    ReportItem(
        label: "心率",
        value: "hrbpm",
        score: 0,
        category: 1,
        id: 1,
        data: [
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 160, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 100, symbol: "le", total: 160, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 100, max: 160, symbol: "le", total: 160, color: Mild_unhealthiness_color, label: "轻度不健康")
        ],
        trend: "hrbpm",
        explanation: "",
        advice: "hrbpm",
        status: "hR_BPM_Status",
        terms: "HappyCat.Term.Physiology.HR_BPM"
    ),
    ReportItem(
        label: "心率变异性",
        value: "hrv",
        score: 0,
        category: 2,
        id: 2,
        data: [
            ReportSegment(min: 0, max: 50, symbol: "lt", total: 300, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 50, max: 200, symbol: "le", total: 300, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 200, max: 300, symbol: "le", total: 300, color: Mild_unhealthiness_color, label: "轻度不健康")
        ],
        trend: "HRV",
        explanation: "",
        advice: "HRV",
        status: "hrvStatusDisplayName",
        terms: "HappyCat.Term.SaO2.HRV"
    ),
    ReportItem(
        label: "房颤",
        value: "af",
        score: 0,
        category: 11,
        id: 11,
        data: [],
        trend: "af",
        explanation: "",
        advice: "af",
        status: "af",
        terms: "HappyCat.Term.Af"
    ),
    ReportItem(
        label: "收缩压",
        value: "bpsystolic",
        score: 0,
        category: 4,
        id: 4,
        data: [
            ReportSegment(min: 70, max: 90, symbol: "lt", total: 170, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 90, max: 130, symbol: "le", total: 170, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 130, max: 140, symbol: "le", total: 170, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 140, max: 170, symbol: "le", total: 170, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bpsystolic",
        explanation: "",
        advice: "bpsystolic",
        status: "bP_SYSTOLIC_Status",
        terms: "HappyCat.Term.Physiology.BP_SYSTOLIC"
    ),
    ReportItem(
        label: "舒张压",
        value: "bpdiastolic",
        score: 0,
        category: 3,
        id: 3,
        data: [
            ReportSegment(min: 50, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "le", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 80, max: 90, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 90, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bpdiastolic",
        explanation: "",
        advice: "bpdiastolic",
        status: "bP_DIASTOLIC_Status",
        terms: "HappyCat.Term.Physiology.BP_DIASTOLIC"
    ),
    ReportItem(
        label: "血氧饱和度",
        value: "spo2h",
        score: 0,
        category: 10,
        id: 10,
        data: [
            ReportSegment(min: 60, max: 93, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 93, max: 100, symbol: "le", total: 100, color: Excellent_color, label: "优秀")
        ],
        trend: "spo2h",
        explanation: "",
        advice: "spo2h",
        status: "saO2StatusDisplayName",
        terms: "HappyCat.Term.SaO2"
    ),
    ReportItem(
        label: "体重指数",
        value: "bmi",
        score: 0,
        category: 13,
        id: 13,
        data: [
            ReportSegment(min: 15, max: 18.5, symbol: "lt", total: 40, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 18.5, max: 25, symbol: "lt", total: 40, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 25, max: 30, symbol: "lt", total: 40, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 30, max: 35, symbol: "lt", total: 40, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 35, max: 40, symbol: "le", total: 40, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "BMI",
        explanation: "",
        advice: "BMI",
        status: "bmI_Status",
        terms: "HappyCat.Term.Physiology.BMI"
    ),
    ReportItem(
        label: "皮肤年龄",
        value: "age",
        score: 0,
        category: 12,
        id: 12,
        data: [
            ReportSegment(min: 0, max: 150, symbol: "le", total: 150, color: Good_color, label: "良好")
        ],
        trend: "age",
        explanation: "",
        advice: "age",
        status: "",
        terms: "HappyCat.Term.Physiology.AGE"
    ),
    ReportItem(
        label: "血管功能",
        value: "bptau",
        score: 0,
        category: 9,
        id: 9,
        data: [
            ReportSegment(min: 0.0, max: 0.8, symbol: "lt", total: 3.0, color: Severe_unhealthiness_color, label: "重度不健康"),
            ReportSegment(min: 0.8, max: 1.2, symbol: "lt", total: 3.0, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 1.2, max: 1.6, symbol: "lt", total: 3.0, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 1.6, max: 2.2, symbol: "lt", total: 3.0, color: Good_color, label: "良好"),
            ReportSegment(min: 2.2, max: 3.0, symbol: "le", total: 3.0, color: Excellent_color, label: "优秀")
        ],
        trend: "bptau",
        explanation: "",
        advice: "bptau",
        status: "bP_TAU_Status",
        terms: "HappyCat.Term.Physiology.BP_TAU"
    ),
    ReportItem(
        label: "心脏压力",
        value: "bppp",
        score: 0,
        category: 8,
        id: 8,
        data: [
            ReportSegment(min: 3.5, max: 3.8, symbol: "lt", total: 4.5, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 3.8, max: 3.9, symbol: "lt", total: 4.5, color: Good_color, label: "良好"),
            ReportSegment(min: 3.9, max: 4.1, symbol: "lt", total: 4.5, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 4.1, max: 4.2, symbol: "lt", total: 4.5, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 4.2, max: 4.5, symbol: "le", total: 4.5, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bppp",
        explanation: "",
        advice: "bppp",
        status: "bP_RPP_Status",
        terms: "HappyCat.Term.Physiology.BP_RPP"
    ),
    ReportItem(
        label: "心脏病风险",
        value: "bpheartattack",
        score: 0,
        category: 5,
        id: 5,
        data: [
            ReportSegment(min: 0.0, max: 1.5, symbol: "lt", total: 7.5, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 1.5, max: 3.0, symbol: "lt", total: 7.5, color: Good_color, label: "良好"),
            ReportSegment(min: 3.0, max: 4.5, symbol: "lt", total: 7.5, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 4.5, max: 6.0, symbol: "lt", total: 7.5, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 6.0, max: 7.5, symbol: "le", total: 7.5, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bpheartattack",
        explanation: "",
        advice: "bpheartattack",
        status: "bP_HEART_ATTACK_Status",
        terms: "HappyCat.Term.Physiology.BP_HEART_ATTACK"
    ),
    ReportItem(
        label: "中风风险",
        value: "bpstroke",
        score: 0,
        category: 7,
        id: 7,
        data: [
            ReportSegment(min: 0.0, max: 1.5, symbol: "lt", total: 7.5, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 1.5, max: 3.0, symbol: "lt", total: 7.5, color: Good_color, label: "良好"),
            ReportSegment(min: 3.0, max: 4.5, symbol: "lt", total: 7.5, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 4.5, max: 6.0, symbol: "lt", total: 7.5, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 6.0, max: 7.5, symbol: "le", total: 7.5, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bpstroke",
        explanation: "",
        advice: "bpstroke",
        status: "bP_STROKE_Status",
        terms: "HappyCat.Term.Physiology.BP_STROKE"
    ),
    ReportItem(
        label: "心血管病风险",
        value: "bpcvd",
        score: 0,
        category: 6,
        id: 6,
        data: [
            ReportSegment(min: 0.0, max: 3.0, symbol: "lt", total: 15.0, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 3.0, max: 6.0, symbol: "lt", total: 15.0, color: Good_color, label: "良好"),
            ReportSegment(min: 6.0, max: 9.0, symbol: "lt", total: 15.0, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 9.0, max: 12.0, symbol: "lt", total: 15.0, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 12.0, max: 15.0, symbol: "le", total: 15.0, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "bpcvd",
        explanation: "",
        advice: "bpcvd",
        status: "bP_CVD_Status",
        terms: "HappyCat.Term.Physiology.BP_CVD"
    ),
    ReportItem(
        label: "情绪综合分",
        value: "emotionscore",
        score: 0,
        category: 20,
        id: 20,
        data: [
            ReportSegment(min: 0, max: 60, symbol: "lt", total: 100, color: Severe_unhealthiness_color, label: "重度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Severe_unhealthiness_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 90, symbol: "lt", total: 100, color: Severe_unhealthiness_color, label: "良好"),
            ReportSegment(min: 90, max: 100, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
        ],
        trend: "emotionscore",
        explanation: "",
        advice: "emotionscore",
        status: "emotionscore",
        terms: ""
    ),
    ReportItem(
        label: "攻击性(负向)",
        value: "aggressivity",
        score: 0,
        category: 21,
        id: 21,
        data: [
            ReportSegment(min: 0, max: 20, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 20, max: 40, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "aggressivity",
        explanation: "",
        advice: "aggressivity",
        status: "aggressivity",
        terms: ""
    ),
    ReportItem(
        label: "焦虑度(负向)",
        value: "anxiety",
        score: 0,
        category: 22,
        id: 22,
        data: [
            ReportSegment(min: 0, max: 20, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 20, max: 40, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "anxiety",
        explanation: "",
        advice: "anxiety",
        status: "anxiety",
        terms: ""
    ),
    ReportItem(
        label: "抑郁度(负向)",
        value: "depress",
        score: 0,
        category: 23,
        id: 23,
        data: [
            ReportSegment(min: 0, max: 20, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 20, max: 40, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "depress",
        explanation: "",
        advice: "depress",
        status: "depress",
        terms: ""
    ),
    ReportItem(
        label: "疲劳度(负向)",
        value: "fatigue",
        score: 0,
        category: 27,
        id: 27,
        data: [
            ReportSegment(min: 0, max: 20, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 20, max: 40, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "fatigue",
        explanation: "",
        advice: "fatigue",
        status: "fatigue",
        terms: ""
    ),
    ReportItem(
        label: "压力度(负向)",
        value: "msi",
        score: 0,
        category: 28,
        id: 28,
        data: [
            ReportSegment(min: 0, max: 20, symbol: "lt", total: 100, color: Good_color, label: "良好"),
            ReportSegment(min: 20, max: 40, symbol: "lt", total: 100, color: Excellent_color, label: "优秀"),
            ReportSegment(min: 40, max: 60, symbol: "lt", total: 100, color: Mild_unhealthiness_color, label: "轻度不健康"),
            ReportSegment(min: 60, max: 80, symbol: "lt", total: 100, color: Moderately_unhealthy_color, label: "中度不健康"),
            ReportSegment(min: 80, max: 100, symbol: "le", total: 100, color: Severe_unhealthiness_color, label: "重度不健康")
        ],
        trend: "MSI",
        explanation: "",
        advice: "MSI",
        status: "msI_Status",
        terms: "HappyCat.Term.Physiology.MSI"
    )
]

// MARK: - Color Hex 扩展
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}


enum ReportMetricKey: Int,CaseIterable {
    case synthesis     = 0 //综合心健康风险
    case hr_bpm        = 1 //心率
    case hrv           = 2 //心率变异性
    case bpdiastolic   = 3 //舒张压
    case bp_sys        = 4 //收缩压
    case bp_dia        = 5 //心脏病风险
    case bpcvd         = 6 //心血管病风险
    case bpstroke      = 7 //中风风险
    case bppp          = 8 //心脏压力
    case bptau         = 9 //血管功能
    case spo2h         = 10 //血氧饱和度
    case af            = 11 //房颤

    case age           = 12 //皮肤年龄
    case bmi           = 13 //体重指数
    
    case emotionscore           = 20 //情绪综合分
    case aggressivity           = 21 //攻击性(负向)
    case depression             = 22 //焦虑度(负向)
    case vitality               = 24 //活力度(正向)
    case suppression            = 26 //抑郁度(负向)
    case fatigue                = 27 //疲劳度(负向)
    case msi                    = 28 //压力度(负向)

}


// MARK: - ReportResult Extension
extension ReportResult {
    
    init(report: Report) {
        var items: [ReportItem] = []
        
        // 遍历 reportConfig，根据 id 与 ReportMetricKey 关联
        for config in reportConfig {
            guard let key = ReportMetricKey(rawValue: config.id) else {
                continue
            }
            
            // 提取 Report 中对应的值
            let reportResult = ReportResult.extractValue(for: key, from: report)
            if let reportResult = reportResult {
                // 生成新的 ReportItem
                let item = ReportItem(
                    label: config.label,
                    value: config.value,
                    score: reportResult.0,
                    category: config.category,
                    id: config.id,
                    data: config.data, // 直接复用 reportConfig 中的 segments
                    trend: config.trend,
                    explanation:reportResult.1,
                    advice: reportResult.2,
                    status: config.status,
                    terms: config.terms
                )
                items.append(item)
            }
            
        }
        
        self.items = items
    }
    
    // MARK: - Extract Value
    static func extractValue(for key: ReportMetricKey, from report: Report) -> (Double,String,String)? {
        switch key {
        case .synthesis:
            let score:Double = report.hasPhysiologyScoreReport ? report.physiologyScoreReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.physiologyScoreReport.explanation)
            let advice = ReportResult.buildAdviceText(report.physiologyScoreReport.explanation)
            return(score,explanation,advice)
        case .hr_bpm:
            let score:Double = report.hasHrReport && report.hrReport.hasData_p ? report.hrReport.data_p.hrBpm : 0
            let explanation = ReportResult.buildExplanationText(report.hrReport.explanation.hrBpm)
            let advice = ReportResult.buildAdviceText(report.hrReport.explanation.hrBpm)
            return(score,explanation,advice)
        case .hrv:
            let score:Double =  report.hasHrReport && report.hrReport.hasData_p ? report.hrReport.data_p.hrv : 0
            let explanation = ReportResult.buildExplanationText(report.hrReport.explanation.hrv)
            let advice = ReportResult.buildAdviceText(report.hrReport.explanation.hrv)
            return(score,explanation,advice)
        case .bpdiastolic:
            let score:Double = report.hasBpReport && report.bpReport.hasData_p ? report.bpReport.data_p.bpDiastolic : 0
            let explanation = ReportResult.buildExplanationText(report.bpReport.explanation.bpDiastolic)
            let advice = ReportResult.buildAdviceText(report.bpReport.explanation.bpDiastolic)
            return(score,explanation,advice)
        case .bp_sys:
            let score:Double = report.hasBpReport && report.bpReport.hasData_p ? report.bpReport.data_p.bpSystolic : 0
            let explanation = ReportResult.buildExplanationText(report.bpReport.explanation.bpSystolic)
            let advice = ReportResult.buildAdviceText(report.bpReport.explanation.bpSystolic)
            return(score,explanation,advice)
        case .bp_dia:
            let score:Double = report.hasRiskReport && report.riskReport.hasData_p ? report.riskReport.data_p.bpHeartAttack: 0
            let explanation = ReportResult.buildExplanationText(report.riskReport.explanation.bpHeartAttack)
            let advice = ReportResult.buildAdviceText(report.riskReport.explanation.bpHeartAttack)
            return(score,explanation,advice)

        case .bpcvd:
            let score:Double = report.hasRiskReport && report.riskReport.hasData_p ? report.riskReport.data_p.bpCvd : 0
            let explanation = ReportResult.buildExplanationText(report.riskReport.explanation.bpCvd)
            let advice = ReportResult.buildAdviceText(report.riskReport.explanation.bpCvd)
            return(score,explanation,advice)

        case .bpstroke:
            let score:Double = report.hasRiskReport && report.riskReport.hasData_p ? report.riskReport.data_p.bpStroke : 0
            let explanation = ReportResult.buildExplanationText(report.riskReport.explanation.bpStroke)
            let advice = ReportResult.buildAdviceText(report.riskReport.explanation.bpStroke)
            return(score,explanation,advice)
        case .bppp:
            let score:Double = report.hasRiskReport && report.riskReport.hasData_p ? report.riskReport.data_p.bpPp : 0
            let explanation = ReportResult.buildExplanationText(report.riskReport.explanation.bpPp)
            let advice = ReportResult.buildAdviceText(report.riskReport.explanation.bpPp)
            return(score,explanation,advice)
        case .bptau:
            let score:Double = report.hasRiskReport && report.riskReport.hasData_p ? report.riskReport.data_p.bpTau : 0
            let explanation = ReportResult.buildExplanationText(report.riskReport.explanation.bpTau)
            let advice = ReportResult.buildAdviceText(report.riskReport.explanation.bpTau)
            return(score,explanation,advice)
        case .spo2h:
            let score:Double = report.hasSpo2HReport ? report.spo2HReport.data_p: 0
            let explanation = ReportResult.buildExplanationText(report.spo2HReport.explanation)
            let advice = ReportResult.buildAdviceText(report.spo2HReport.explanation)
            return(score,explanation,advice)
        case .af:
            let score:Double = report.hasAfReport ? report.afReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.afReport.explanation)
            let advice = ReportResult.buildAdviceText(report.afReport.explanation)
            return(score,explanation,advice)
        case .age:
            let score:Double = Double(report.hasEssentialReport ? report.essentialReport.data_p.age : 0)
            let explanation = ReportResult.buildExplanationText(report.essentialReport.explanation.age)
            let advice = ReportResult.buildAdviceText(report.essentialReport.explanation.age)
            return(score,explanation,advice)
        case .bmi:
            let score:Double = report.hasEssentialReport && report.essentialReport.hasData_p ? report.essentialReport.data_p.bmi : 0
            let explanation = ReportResult.buildExplanationText(report.essentialReport.explanation.bmi)
            let advice = ReportResult.buildAdviceText(report.essentialReport.explanation.bmi)
            return(score,explanation,advice)
        case .emotionscore:
            let score:Double = report.hasEmotionScoreReport ? report.emotionScoreReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.emotionScoreReport.explanation)
            let advice = ReportResult.buildAdviceText(report.emotionScoreReport.explanation)
            return(score,explanation,advice)
        case .aggressivity:
            let score:Double = report.hasAggressivityReport ? report.aggressivityReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.aggressivityReport.explanation)
            let advice = ReportResult.buildAdviceText(report.aggressivityReport.explanation)
            return(score,explanation,advice)
        case .depression:
            let score:Double = report.hasAnxietyReport ? report.anxietyReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.anxietyReport.explanation)
            let advice = ReportResult.buildAdviceText(report.anxietyReport.explanation)
            return(score,explanation,advice)
        case .vitality:
            let score:Double = report.hasVitalityReport ? report.vitalityReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.vitalityReport.explanation)
            let advice = ReportResult.buildAdviceText(report.vitalityReport.explanation)
            return(score,explanation,advice)
        case .suppression:
            let score:Double = report.hasSuppressionReport ? report.suppressionReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.suppressionReport.explanation)
            let advice = ReportResult.buildAdviceText(report.suppressionReport.explanation)
            return(score,explanation,advice)
        case .fatigue:
            let score:Double = report.hasFatigueReport ? report.fatigueReport.data_p: 0
            let explanation = ReportResult.buildExplanationText(report.fatigueReport.explanation)
            let advice = ReportResult.buildAdviceText(report.fatigueReport.explanation)
            return(score,explanation,advice)
        case .msi:
            let score:Double = report.hasMsiReport ? report.msiReport.data_p : 0
            let explanation = ReportResult.buildExplanationText(report.msiReport.explanation)
            let advice = ReportResult.buildAdviceText(report.msiReport.explanation)
            return(score,explanation,advice)
        }
    }
    
    
    
    
   static func buildExplanationText(_ exp: ReportIndexExplanation?) -> String {
        guard let exp = exp else { return "" }
        var result = ""
        
        if exp.detailsArray_Count > 0 {
            for case let d as ReportIndexText in exp.detailsArray {
                let values = (d.valuesArray as? [String] ?? []).joined(separator: ", ")
                result += "· \(d.name ?? ""): \(values)\n"
            }
            result += "\n"
        }
        let newString = result.replacingOccurrences(of:"· 概念解释:", with: "")
        
        return newString
    }

    static func buildAdviceText(_ exp: ReportIndexExplanation?) -> String {
        guard let exp = exp else { return "" }
        var result = ""
        
        if exp.advicesArray_Count > 0 {
            for case let a as ReportIndexText in exp.advicesArray {
                let values = (a.valuesArray as? [String] ?? []).joined(separator: ", ")
                result += "· \(a.name ?? ""): \(values)\n"
            }
        }
        let newString = result.replacingOccurrences(of:"· 健康建议:", with: "")
        
        return newString
    }


   

}


