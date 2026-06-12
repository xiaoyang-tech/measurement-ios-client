//
//  HeartRateCard.swift
//  MeasurementSDK
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI

struct HeartRateRariabilityCard: View {
    var value: Double = 91
    var textColor:Color = Good_color
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 12) {
                
                // 图标 + 标题
                HStack {
                    Rectangle()
                        .fill(speratorLineHor_color)
                        .frame(width: 1.5, height: 20)   // ← 小色块矩形
                    Image("hrbpm")
                        .foregroundColor(.gray)
                    Text("心率变异性")
                        .font(.system(size: 17, weight: .medium))
                }
                
                HStack(alignment: .center) {
                    // 数值
                    Text("\(Int(value))")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(textColor)
                        .frame(width: 60, alignment: .leading)

                    // ⭐ 加大与右侧横条的间距
                    Spacer().frame(width: 20)
                    
                    // 横条 + 游标
                    SegmentedBarSlider(
                        value: value,
                        minValue: 0,
                        maxValue: 300,
                        segments: [
                            Segment(start: 0, end: 50, color: Mild_unhealthiness_color),
                            Segment(start: 50, end: 200, color: Excellent_color),
                            Segment(start: 200, end: 300, color: Mild_unhealthiness_color)
                        ]
                    )
                }
            }
        }
    }
}
