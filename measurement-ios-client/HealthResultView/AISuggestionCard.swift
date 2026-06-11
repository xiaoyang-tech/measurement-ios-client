//
//  AISuggestionCard.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct AISuggestionCard: View {
    var body: some View {
            CardContainer {
                VStack(alignment: .leading, spacing: 12) {
                    Text("AI 健康建议")
                        .font(.system(size: 17, weight: .medium))

                    HStack(spacing: 12) {
                        AdviceItem(icon: "leaf.fill", title: "中医养生", color: .green) {
                            print("点击了 中医养生")
                        }

                        
                        AdviceItem(icon: "applelogo", title: "每日饮食", color: .red) {
                            print("点击了 每日饮食")
                        }

                        AdviceItem(icon: "heart.fill", title: "每日心理", color: .green) {
                            print("点击了 每日心理")
                        }

                        AdviceItem(icon: "figure.walk", title: "每日运动", color: .blue) {
                            print("点击了 每日运动")
                        }

                        AdviceItem(icon: "bed.double.fill", title: "每日睡眠", color: .yellow) {
                            print("点击了 每日睡眠")
                        }

                    }
                }
            }
        }
}

struct AdviceItem: View {
    let icon: String
    let title: String
    let color: Color
    let onTap: () -> Void        // ← 新增

    var body: some View {
        VStack(spacing: 6) {
            Image(systemName: icon)
                .font(.system(size: 20))
                .foregroundColor(color)
            Text(title)
                .font(.system(size: 12))
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(Color.white)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.gray.opacity(0.25), lineWidth: 1)
        )
        .cornerRadius(12)
        .onTapGesture {
            onTap()                  // ← 调用点击事件
        }
    }
}
