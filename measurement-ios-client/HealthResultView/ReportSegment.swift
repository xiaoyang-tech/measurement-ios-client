//
//  ReportSegment.swift
//  MeasurementSDK
//
//  Created by DCK on 2025/12/10.
//  Copyright © 2025 CocoaPods. All rights reserved.
//


import SwiftUI

// MARK: - 通用卡片组件
struct ReportCard: View {
    let item: ReportItem
    let color: Color

    // 自动计算 min/max
    var minValue: Double {
        item.data.map { $0.min }.min() ?? 0
    }
    
    var maxValue: Double {
        item.data.map { $0.max }.max() ?? 100
    }
    
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 12) {
                // 图标 + 标题
                HStack {
                    Rectangle()
                        .fill(speratorLineHor_color)
                        .frame(width: 1.5, height: 20)
                    Image("\(item.value)") // 可替换成动态图标
                        .foregroundColor(.gray)
                    Text(item.label)
                        .font(.system(size: 16, weight: .medium))
                }
                
                HStack(alignment: .center) {
                    // 数值
                    Text(item.score.truncatingRemainder(dividingBy: 1) == 0
                         ? String(format: "%.0f", item.score)
                         : String(format: "%.2f", item.score))
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(color)
                        .frame(width: 60, alignment: .leading)
                    
                    Spacer().frame(width: 20)
                    
                    // 横条 + 游标
                    SegmentedBarSlider(
                        value: item.score,
                        minValue: minValue,
                        maxValue: maxValue,
                        segments: item.data.map { Segment(start: $0.min, end: $0.max, color: $0.color) }
                    )
                }
            }
        }
    }
}
