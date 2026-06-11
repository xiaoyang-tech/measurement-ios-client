//
//  CardContainer.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct CardContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        content
            .padding(16)
            .frame(maxWidth: 360, alignment: .leading)   // ⭐ 控制最大宽度
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: .black.opacity(0.06), radius: 6, y: 4)
            .padding(.horizontal, 16)                    // ⭐ 页面左右边距
            .frame(maxWidth: .infinity, alignment: .center) // ⭐ 居中，不撑开内容宽度
    }
}
