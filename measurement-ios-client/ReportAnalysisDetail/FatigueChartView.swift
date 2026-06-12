import SwiftUI

struct LineChartView: View {
    let data: [Double]
    var showPoints: Bool = true
    var lineWidth: CGFloat = 3
    var gradient: [Color] = [Color.blue.opacity(0.6), Color.blue.opacity(0.1)]
    
    @State private var animateRatio: CGFloat = 0
    
    private var minY: Double { data.min() ?? 0 }
    private var maxY: Double { data.max() ?? 1 }
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                
                // ⭐ 渐变填充区域
                fillPath(size: geo.size)
                    .fill(
                        LinearGradient(
                            gradient: Gradient(colors: gradient),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .opacity(0.8)
                    .animation(.easeOut(duration: 0.6), value: animateRatio)
                
                // ⭐ 折线
                linePath(size: geo.size)
                    .trim(from: 0, to: animateRatio)
                    .stroke(
                        LinearGradient(
                            gradient: Gradient(colors: gradient),
                            startPoint: .leading,
                            endPoint: .trailing
                        ),
                        style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, lineJoin: .round)
                    )
                    .animation(.easeOut(duration: 0.6), value: animateRatio)
                
                // ⭐ 数据点
                if showPoints {
                    pointsView(size: geo.size)
                        .opacity(Double(animateRatio))
                }
            }
            .onAppear {
                animateRatio = 1
            }
        }
        .frame(height: 160)
    }
    
    // MARK: - 线条路径
    private func linePath(size: CGSize) -> Path {
        var path = Path()
        guard data.count > 1 else { return path }
        
        for index in data.indices {
            let x = xPos(index: index, width: size.width)
            let y = yPos(value: data[index], height: size.height)
            
            if index == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
    
    // MARK: - 填充区域路径
    private func fillPath(size: CGSize) -> Path {
        var path = linePath(size: size)
        
        // 封底到最底部形成面积区域
        if let last = data.indices.last {
            let lastX = xPos(index: last, width: size.width)
            path.addLine(to: CGPoint(x: lastX, y: size.height))
            
            let firstX = xPos(index: 0, width: size.width)
            path.addLine(to: CGPoint(x: firstX, y: size.height))
            
            path.closeSubpath()
        }
        
        return path
    }
    
    // MARK: - 点
    private func pointsView(size: CGSize) -> some View {
        ForEach(data.indices, id: \.self) { index in
            let x = xPos(index: index, width: size.width)
            let y = yPos(value: data[index], height: size.height)
            
            Circle()
                .fill(Color.white)
                .frame(width: 10, height: 10)
                .overlay(
                    Circle().stroke(gradient.first ?? .blue, lineWidth: 2)
                )
                .position(x: x, y: y)
        }
    }
    
    // MARK: - 工具方法
    private func xPos(index: Int, width: CGFloat) -> CGFloat {
        guard data.count > 1 else { return width / 2 }
        return CGFloat(index) * (width / CGFloat(data.count - 1))
    }
    
    private func yPos(value: Double, height: CGFloat) -> CGFloat {
        let range = maxY - minY
        if range == 0 { return height / 2 }
        
        let percent = (value - minY) / range
        return height - (percent * height)
    }
}

// MARK: - 预览
struct LineChartView_Previews: PreviewProvider {
    static var previews: some View {
        LineChartView(
            data: [10, 30, 22, 70, 55, 90, 60],
            gradient: [Color.red.opacity(0.8), Color.orange.opacity(0.2)]
        )
        .padding()
    }
}
