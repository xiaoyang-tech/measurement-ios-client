//
//  ExplanationCard.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//
import SwiftUI

struct ExplanationCard: View {
    let title: String
    let content: String
    
    @State private var expanded: Bool = false
    @Namespace private var animationNamespace
    
    // 卡片圆角半径
    private let cardCornerRadius: CGFloat = 12
    
    var body: some View {
        VStack(spacing: 0) {
            // 标题标签
            HStack {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        RoundedCorner(radius: cardCornerRadius, corners: [.topLeft, .bottomRight])
                            .fill(Color.blue)
                    )
                Spacer()
            }
            .padding(.top, 0) // 紧贴卡片边框顶部
            .padding(.leading, 0) // 紧贴卡片左边
            
            // 正文
            VStack(alignment: .leading, spacing: 8) {
                Text(content)
                    .font(.subheadline)
                    .foregroundColor(.primary)
                    .lineLimit(expanded ? nil : 2)
                    .animation(.easeInOut(duration: 0.25), value: expanded)
                
                HStack {
                    Spacer()
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            expanded.toggle()
                        }
                    }) {
                        Text(expanded ? "收起" : "更多")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 12)
            .padding(.top, 8)
        }
        .background(
            RoundedRectangle(cornerRadius: cardCornerRadius)
                .stroke(Color.blue, lineWidth: 1)
        )
        .padding(.horizontal, 20)
    }
}



// 自定义圆角 View
struct RoundedCorner: Shape {
    var radius: CGFloat = 12
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// 测量文本高度辅助 View
struct TextHeightReader: View {
    let text: String
    let font: Font
    var callback: (Bool) -> Void

    @State private var fullHeight: CGFloat = 0
    @State private var twoLineHeight: CGFloat = 0

    var body: some View {
        VStack {
            Text(text)
                .font(font)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(nil)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                fullHeight = geo.size.height
                                checkExceeds()
                            }
                            .onChange(of: geo.size.height) { _ in
                                fullHeight = geo.size.height
                                checkExceeds()
                            }
                    }
                )

            Text("A\nA") // 两行高度
                .font(font)
                .fixedSize(horizontal: false, vertical: true)
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                twoLineHeight = geo.size.height
                                checkExceeds()
                            }
                    }
                )
                .hidden()
        }
    }

    private func checkExceeds() {
        if twoLineHeight > 0 {
            DispatchQueue.main.async {
                callback(fullHeight > twoLineHeight)
            }
        }
    }
}
