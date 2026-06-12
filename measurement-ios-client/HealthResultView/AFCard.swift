//
//  SBPCard.swift
//  measurementSDK_Example
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import SwiftUI

import SwiftUI

struct AFCard: View {
    var value: Double = 1   // -1 发作，=0 未发作
    
    // 动态状态文字
    private var statusText: String {
        value == -1 ? "发作" : "未发作"
    }
    
    // 动态背景颜色
    private var statusColor: Color {
        value == -1
        ? Color(red: 1.0, green: 0.322, blue: 0.322)     // #ff5252
        : Color(red: 0.431, green: 0.855, blue: 0.663)   // #6edaa9
    }

    var body: some View {
        CardContainer {
            
            VStack(alignment: .leading, spacing: 12) {
                
                // 图标 + 标题
                HStack {
                    Rectangle()
                        .fill(speratorLineHor_color)
                        .frame(width: 1.5, height: 20)   // ← 小色块矩形
                    
                    Image("af")
                        .foregroundColor(.gray)
                    Text("房颤")
                        .font(.system(size: 17, weight: .medium))
                }
                
                // 状态标识
                Text(statusText)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 6)
                    .background(statusColor)
                    .cornerRadius(20)
            }
        }
    }
}
