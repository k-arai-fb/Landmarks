/*
 See the LICENSE.txt file for this sample’s licensing information.
 
 Abstract:
 The elevation, heart rate, and pace of a hike plotted on a graph.
 */

import SwiftUI

/// KeyPathを使わない一般的な実装。
/// Hikeに限らず、Rangeのリストを用意すれば、グラフが表示できる設計
struct HikeGraph2: View {
    // Viewの表示に必要な最低限の要素
    let data: [Range<Double>]
    let mode: Mode
    
    enum Mode {
        case elevation, heartRate, pace
    }
    
    var color: Color {
        switch mode {
        case .elevation:
            return .gray
        case .heartRate:
            return Color(hue: 0, saturation: 0.5, brightness: 0.7)
        case .pace:
            return Color(hue: 0.66, saturation: 0.4, brightness: 0.7)
        }
    }
    
    var body: some View {
        let overallRange = rangeOfRanges(data)
        let maxMagnitude = data.map { magnitude(of: $0) }.max()!
        let heightRatio = 1 - CGFloat(maxMagnitude / magnitude(of: overallRange))
        
        return GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                ForEach(Array(data.enumerated()), id: \.offset) { index, range in
                    GraphCapsule(
                        index: index,
                        color: color,
                        height: proxy.size.height,
                        range: range,
                        overallRange: overallRange
                    )
                }
                .offset(x: 0, y: proxy.size.height * heightRatio)
            }
        }
    }
}

#Preview {
    let hike = ModelData().hikes[0]
    return Group {
        HikeGraph2(data: hike.observations.map(\.elevation), mode: .elevation)
            .frame(height: 200)
        HikeGraph2(data: hike.observations.map(\.heartRate), mode: .heartRate)
            .frame(height: 200)
        HikeGraph2(data: hike.observations.map(\.pace), mode: .pace)
            .frame(height: 200)
    }
}
