//
//  HealthSuggestionCard.swift
//  MeasurementSDK
//
//  Created by Baron on 2025/12/7.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import SwiftUI

struct HealthSuggestionCard: View {
    var advice: String
    var body: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 8) {
                Text("健康建议")
                    .font(.system(size: 17, weight: .medium))

                Text("\(advice)")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
}
