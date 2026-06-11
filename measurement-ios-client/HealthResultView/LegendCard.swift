//
//  LegendCard.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct LegendCard: View {
    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 12) {
                
                Text("报告图例")
                    .font(.system(size: 17, weight: .semibold))
                
                LazyVGrid(columns: columns, alignment: .leading, spacing: 12) {
                    LegendItem(color: Excellent_color, title: "优秀")
                    LegendItem(color: Good_color, title: "良好")
                    LegendItem(color: Mild_unhealthiness_color, title: "轻度不健康")
                    LegendItem(color: Moderately_unhealthy_color, title: "中度不健康")
                    LegendItem(color: Severe_unhealthiness_color, title: "重度不健康")
                }
                
                Text("点击报告单项，可以查看每项指标详情！")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
            }
        }
    }
}

struct LegendItem: View {
    var color: Color
    var title: String

    var body: some View {
        HStack(spacing: 8) {
            Rectangle()
                .fill(color)
                .frame(width: 18, height: 10)   // ← 小色块矩形
                .cornerRadius(2)
            
            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.black)
        }
    }
}
