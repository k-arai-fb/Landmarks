/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A single line in the graph.
*/

import SwiftUI


struct GraphCapsule: View, Equatable {
    var index: Int
    var color: Color
    var height: CGFloat
    var range: Range<Double> 
    var overallRange: Range<Double>
    var heightRatio: CGFloat {
        max(CGFloat(magnitude(of: range) / magnitude(of: overallRange)), 0.15)
    }
    
    // カプセルの縦方向のオフセット（下端からの比率）
    var offsetRatio: CGFloat {
        //magnitude=range.upperBound - range.lowerBound
        CGFloat((range.lowerBound - overallRange.lowerBound) / magnitude(of: overallRange))
    }
    
    var body: some View {
        //標準図形
        Capsule()
            .fill(color)
            .frame(height: height * heightRatio)
            .offset(x: 0, y: height * -offsetRatio)
    }
}


#Preview {
    GraphCapsule(
        index: 0,
        color: .blue,
        height: 150,
        range: 10..<50,
        overallRange: 0..<100)
}

