//
//  FatigueReportView.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct FatigueReportView: View {
    let title:String
    let fatigueScore: Double
    let fatigueLevelText: String
    let chartData: [Double]
    let chartGradient: [Color]
    let explanationText: String
    let adviceText: String
    let fatigueColor:Color
    @State private var animationProgress: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // 主要指标区域
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text("\(title)")
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.leading, 20)
                        Spacer()
                        Text(fatigueLevelText)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(fatigueColor)
                            .padding(.trailing, 20)
                    }
                    
                    Spacer()
                    Text(String(format: "%.2f", fatigueScore))
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .foregroundColor(fatigueColor)
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                }
                
                
                HStack(alignment: .center, spacing: 8) {
                    
                    // 左侧刻度
                    VStack(alignment: .trailing, spacing: 22) {
                        Text("100").font(.caption).foregroundColor(.secondary)
                        Text("75").font(.caption).foregroundColor(.secondary)
                        Text("50").font(.caption).foregroundColor(.secondary)
                        Text("25").font(.caption).foregroundColor(.secondary)
                        Text("0").font(.caption).foregroundColor(.secondary)
                    }
                    
                    ZStack {
                        
                        // 横线
                        VStack(spacing: 0) {
                            ForEach(0..<5) { _ in
                                Rectangle()
                                    .fill(Color.gray.opacity(0.2))
                                    .frame(height: 1)
                                Spacer()
                            }
                        }
                        
                        // 折线图
                        LineChartView(
                            data: chartData,
                            gradient: chartGradient
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.top, 8)
                
                // 概念解释
                ExplanationCard(
                    title: "概念解释",
                    content: explanationText
                )
                
                // 健康建议
                ExplanationCard(
                    title: "健康建议",
                    content: adviceText
                )
            }
            .background(Color(.systemBackground))
            .padding(.vertical)
            .onAppear {
                // 启动填充动画
                withAnimation(.easeOut(duration: 1.5)) {
                    animationProgress = 1.0
                }
            }
        }
    }
}
