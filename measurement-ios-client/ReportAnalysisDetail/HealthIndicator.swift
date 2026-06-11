//
//  HealthIndicator.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI

struct HealthIndicator {
    let name: String
    let score: Double
    let direction: HealthDirection
    let range: ClosedRange<Double>
    
    enum HealthDirection {
        case negative // 负向指标，值越高越不好
        case positive // 正向指标，值越高越好
    }
    
    var healthLevel: HealthLevel {
        switch score {
        case range.lowerBound..<40:
            return .healthy
        case 40..<70:
            return .mildUnhealthy
        case 70...range.upperBound:
            return .severeUnhealthy
        default:
            return .mildUnhealthy
        }
    }
}

enum HealthLevel: String {
    case healthy = "健康"
    case mildUnhealthy = "轻度不健康"
    case severeUnhealthy = "严重不健康"
    
    var color: Color {
        switch self {
        case .healthy: return .green
        case .mildUnhealthy: return .orange
        case .severeUnhealthy: return .red
        }
    }
}
