import SwiftUI
import MeasurementSDK


struct HealthResultView: View {
    let result: ReportResult?
    let onSelectItem: (ReportItem, (Color, String)) -> Void

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                if let result = result {
                    ForEach(result.items, id: \.id) { item in
                        let levelValue = levelForValue(item.score, levels: item.data)

                        Button {
                            onSelectItem(item, levelValue)
                        } label: {
                            itemContentView(item: item, color: levelValue.0)
                        }
                        .buttonStyle(.plain)
                    }

                    HealthSuggestionCard(
                        advice: result.items.first?.advice ?? ""
                    )
                    AISuggestionCard()
                    LegendCard()
                } else {
                    Text("暂无数据")
                        .foregroundColor(.gray)
                }
            }
            .padding(.vertical)
        }
    }

    @ViewBuilder
    private func itemContentView(
        item: ReportItem,
        color: Color
    ) -> some View {
        if item.id == 0 {
            HealthGaugeView(score: item.score, color: color)
        } else if item.id == 20 {
            ECSCard(score: item.score, color: color)
        } else if item.id == 11 {
            AFCard(value: item.score)
        } else {
            ReportCard(item: item, color: color)
        }
    }
}

// MARK: - Helper
func levelForValue(_ value: Double, levels: [ReportSegment]) -> (Color, String) {
    for level in levels {
        if value >= level.min && value < level.max {
            return (level.color, level.label)
        }
    }
    return (Severe_unhealthiness_color, "异常")
}
