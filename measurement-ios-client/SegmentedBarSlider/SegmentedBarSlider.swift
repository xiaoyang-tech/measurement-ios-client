//
//  SegmentedBarSlider.swift
//  MeasurementSDK
//
//  Created by DCK on 2025/12/5.
//  Copyright © 2025 CocoaPods. All rights reserved.
//


import SwiftUI

struct SegmentedBarSlider: View {
    var value: Double
    var minValue: Double
    var maxValue: Double
    var segments: [Segment]

    private let barHeight: CGFloat = 8
    private let barCornerRadius: CGFloat = 4
    private let cursorSize: CGFloat = 16

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {

            ZStack(alignment: .leading) {
                GeometryReader { geo in
                    let width = geo.size.width
                    let segmentWidth = width / CGFloat(segments.count)

                    // —— 色块 ——
                    HStack(spacing: 0) {
                        ForEach(segments) { seg in
                            Rectangle()
                                .fill(seg.color)
                                .frame(width: segmentWidth, height: barHeight)
                        }
                    }
                    .cornerRadius(barCornerRadius)

                    // —— 光标位置计算 ——
                    let cursorX: CGFloat = {
                        if let index = segments.firstIndex(where: { value <= $0.end }) {
                            let s = segments[index]
                            let start = index == 0 ? minValue : segments[index - 1].end
                            let percent = (value - start) / (s.end - start)
                            return CGFloat(index) * segmentWidth + segmentWidth * CGFloat(percent)
                        } else {
                            return width
                        }
                    }()

                    // —— 光标 ——
                    Circle()
                        .fill(Color.white)
                        .frame(width: cursorSize, height: cursorSize)
                        .shadow(color: .black.opacity(0.15), radius: 3)
                        .overlay(
                            Circle().stroke(Color.gray.opacity(0.3), lineWidth: 1)
                        )
                        .position(x: cursorX, y: barHeight / 2)
                }
                .frame(height: cursorSize)
            }

            // —— 动态刻度（自动生成 0, 0.8, 1.2, 1.6, 2.2, 3） ——
            HStack {
                ForEach(0...segments.count, id: \.self) { i in
                    let tick: Double = {
                        if i == 0 {
                            return segments.first?.start ?? minValue   // 0
                        } else if i == segments.count {
                            return segments.last?.end ?? maxValue      // 3
                        } else {
                            return segments[i].start                    // 0.8, 1.2, 1.6, 2.2
                        }
                    }()

                    Text(formatTick(tick))
                        .font(.system(size: 13))
                        .foregroundColor(.gray)

                    if i < segments.count { Spacer() }
                }
            }
        }
    }

    // 保证显示为 "0", "0.8", "1.2"
    private func formatTick(_ v: Double) -> String {
        if v.truncatingRemainder(dividingBy: 1) == 0 {
            return String(format: "%.0f", v)
        }
        return String(format: "%.1f", v)
    }
}
