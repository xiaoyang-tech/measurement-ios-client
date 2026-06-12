//
//  HealthScoreChart.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI

struct HealthScoreChart: View {
    let indicator: HealthIndicator
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 4) {
            // 刻度标签
            HStack {
                if indicator.direction == .negative {
                    Text("100")
                    Spacer()
                    Text("0")
                } else {
                    Text("0")
                    Spacer()
                    Text("100")
                }
            }
            .font(.caption)
            .foregroundColor(.secondary)
            
            // 图表
            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    // 背景轨道
                    Capsule()
                        .fill(Color.gray.opacity(0.2))
                        .frame(height: 8)
                    
                    // 填充条
                    Capsule()
                        .fill(indicator.healthLevel.color)
                        .frame(width: calculateFillWidth(width: geometry.size.width))
                        .frame(height: 8)
                    
                    // 指示器
                    Circle()
                        .fill(Color.white)
                        .frame(width: 20, height: 20)
                        .overlay(Circle().stroke(indicator.healthLevel.color, lineWidth: 3))
                        .position(x: calculateIndicatorPosition(width: geometry.size.width), 
                                 y: geometry.size.height / 2)
                }
            }
            .frame(height: 20)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    animationProgress = 1.0
                }
            }
        }
    }
    
    private func calculateFillWidth(width: CGFloat) -> CGFloat {
        let percentage = indicator.direction == .negative 
            ? (100 - indicator.score) / 100 
            : indicator.score / 100
        
        return width * CGFloat(percentage) * animationProgress
    }
    
    private func calculateIndicatorPosition(width: CGFloat) -> CGFloat {
        let percentage = indicator.direction == .negative 
            ? (100 - indicator.score) / 100 
            : indicator.score / 100
        
        return width * CGFloat(percentage) * animationProgress
    }
}
