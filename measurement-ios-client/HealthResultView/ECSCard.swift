//
//  ECSCard.swift
//  measurementSDK_Example
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation


import SwiftUI

struct ECSCard: View {
    var score: Double// 0~100
    var color: Color
    private let gaugeWidth: CGFloat = 4
    private let spacing: Double = 12


    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: spacing) {
                // 图标 + 标题
                HStack {
                    Rectangle()
                        .fill(speratorLineHor_color)
                        .frame(width: 1.5, height: 20)   // ← 小色块矩形
                    
                    Image("emotionscore")
                        .foregroundColor(.gray)
                    // ⭐ 左上角标题永远靠左
                    Text("情绪综合分")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.black)
                }
                                
                // ⭐ Gauge 居中显示，随屏幕自适应
                GeometryReader { geo in
                    let gaugeSize = min(geo.size.width, 300) // 最大宽度 300，也可以根据需要调整
                    
                    ZStack {
                        ECSGaugeArc()
                            .stroke(Color.gray.opacity(0.25),
                                    style: StrokeStyle(lineWidth: gaugeWidth, lineCap: .round))
                        
                        ECSGaugeArc()
                            .trim(from: 0, to: score / 100)
                            .stroke(color,
                                    style: StrokeStyle(lineWidth: gaugeWidth, lineCap: .round))
                            .animation(.easeOut(duration: 1.0), value: score)
                        
                        ECSGaugeTicks()
                        ECSGaugeNumbers()
                        
                        VStack(spacing: 4) {
                            Text("\(Int(score))")
                                .font(.system(size: 40, weight: .bold))
                                .foregroundColor(color)
                            
                            Text("SCORE")
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(.black.opacity(0.1))
                        }
                    }
                    .frame(width: gaugeSize, height: gaugeSize)
                    .position(x: geo.size.width / 2, y: gaugeSize / 2) // 居中
                }
                .frame(height: 300) // 给 GeometryReader 一个固定高度，防止撑开
            }
        }
    }
}

// MARK: - Gauge Arc (¾ circle)
struct ECSGaugeArc: Shape {
    func path(in rect: CGRect) -> Path {
        let startAngle: Angle = .degrees(135)
        let endAngle: Angle = .degrees(405)
        var path = Path()
        path.addArc(center: CGPoint(x: rect.midX, y: rect.midY),
                    radius: rect.width * 0.28,
                    startAngle: startAngle,
                    endAngle: endAngle,
                    clockwise: false)
        return path
    }
}

struct ECSGaugeTicks: View {
    var body: some View {
        ZStack {
            ForEach(1..<62, id: \.self) { i in   // 1~61
                
                // 计算角度：0→61 映射到 270°
                let angle = Double(i) * 270 / 61 - 135
                
                // 判断区间颜色
                let color: Color = {
                    switch i {
                    case 1...36:   return Severe_unhealthiness_color
                    case 37...42:  return Moderately_unhealthy_color
                    case 43...48:  return Mild_unhealthiness_color
                    case 49...53:  return Good_color
                    case 54...61:  return Excellent_color
                    default:       return .gray
                    }
                }()

                // 主/次刻度
//                let isMajor = i % 10 == 0
                let length: CGFloat = 10
                let width: CGFloat  = 2
                let opacity: Double =  1.0

                if #available(iOS 15.0, *) {
                    ECSTick(length: length, width: width, color: color)
                        .foregroundStyle(color)   // ⭐ 颜色放在这里
                        .opacity(opacity)
                        .offset(y: -100)
                        .rotationEffect(.degrees(angle))
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}



struct ECSTick: View {
    var length: CGFloat
    var width: CGFloat
    var color:Color
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: width, height: length)
    }
}


//  MARK: - Numbers (0/20/40/60/80/100)
struct ECSGaugeNumbers: View {
    let labels = [0, 20, 40, 60, 80, 100]

    var body: some View {
        GeometryReader { geo in
            let radius = geo.size.width * 0.33
            let offset = radius + 22

            ZStack {
                ForEach(labels, id: \.self) { value in
                    let angle = 135 + (Double(value) / 100) * 270
                    let rad = angle * .pi / 180
                    let cx = geo.size.width / 2
                    let cy = geo.size.height / 2
                    let x = cx + cos(rad) * offset
                    let y = cy + sin(rad) * offset

                    // 根据 value 设置颜色
                    let color: Color = {
                        switch value {
                        case 0, 20, 40: return .red
                        case 60:        return .orange
                        case 80:        return Color(red: 0.573, green: 0.784, blue: 0.953)
                        case 100:       return Color(red: 0.545, green: 0.843, blue: 0.674)
                        default:        return .gray
                        }
                    }()

                    Text("\(value)")
                        .font(.system(size: 12))
                        .foregroundColor(color)
                        .position(x: x, y: y)
                }
            }
        }
    }
}
