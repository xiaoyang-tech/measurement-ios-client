//
//  HeartRateCard.swift
//  MeasurementSDK
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI

struct HeartRateCard: View {
    var value: Double = 91
    var textColor: Color = Good_color
    var body: some View {
        CardContainer {
            
            VStack(alignment: .leading, spacing: 12) {
                
                // 图标 + 标题
                HStack {
                    Rectangle()
                        .fill(speratorLineHor_color)
                        .frame(width: 1.5, height: 20)   // ← 小色块矩形
                    
                    Image("hrv")
                        .foregroundColor(.gray)
                    Text("心率")
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
                        minValue: 40,
                        maxValue: 160,
                        segments: [
                            Segment(start: 40, end: 60, color: Mild_unhealthiness_color),
                            Segment(start: 60, end: 100, color: Excellent_color),
                            Segment(start: 100, end: 160, color: Mild_unhealthiness_color)
                        ]
                    )
                }
            }
        }
    }
        
    
}
