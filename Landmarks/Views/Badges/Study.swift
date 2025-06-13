//
//  Study.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/09.
//

import SwiftUI
import CoreGraphics

struct Parameters {
    //六角形の一辺に対応
    struct Segment {
        let line: CGPoint
        let curve: CGPoint
        let control: CGPoint
    }
    
    //インスタンスを生成しなくても使える HexagonParameters.adjustment()
    static let adjustment: CGFloat = 0.085
    
    
    static let segments = [
        Segment(
            line:    CGPoint(x: 0.80, y: 0.50),
            curve:   CGPoint(x: 0.50, y: 0.20),
            control: CGPoint(x: 1.0, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.50, y: 0.20 ),
            curve:   CGPoint(x: 0.20, y: 0.50),
            control: CGPoint(x: 0.00, y: 0.00)
        ),
        Segment(
            line:    CGPoint(x: 0.20, y: 0.50 ),
            curve:   CGPoint(x: 0.50, y: 0.80 ),
            control: CGPoint(x: 0.00, y: 1.00 )
        ),
        Segment(
            line:    CGPoint(x: 0.50, y: 0.80 ),
            curve:   CGPoint(x: 0.80, y: 0.50 ),
            control: CGPoint(x: 1.00, y: 1.00 )
        )
    ]
}

struct Study: View {
    let angle: Angle
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            
            
            ZStack {
                Path { path in
                    
                    // 開始点：中央上部
                    path.move(to: CGPoint(x: width * 0.80, y: height * 0.50))
                    
                    Parameters.segments.forEach { segment in
                        
                        // 直線：右上方向へ
                        path.addLine(
                            to: CGPoint(
                                x: width * segment.line.x,
                                y: height * segment.line.y
                            )
                        )
                        
                        // 曲線：左上へ滑らかに移動
                        path.addQuadCurve(
                            to: CGPoint(
                                x: width * segment.curve.x,
                                y: height * segment.curve.y
                            ),
                            control: CGPoint(
                                x: width * segment.control.x,
                                y: height * segment.control.y
                            )
                        )
                    }
                }
                .stroke(.blue, lineWidth: 3)
                .background(Color.white)
                .rotationEffect(angle, anchor: .center)
            }
            
            Path { path in
                
                // 開始点：中央上部
                path.move(to: CGPoint(x: width * 0.80, y: height * 0.50))
                
                Parameters.segments.forEach { segment in
                    
                    // 直線：右上方向へ
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x,
                            y: height * segment.line.y
                        )
                    )
                    
                    // 曲線：左上へ滑らかに移動
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            .stroke(.blue, lineWidth: 3)
        }
        .frame(width: 200, height: 200)
        .border(Color.gray)
    }
}


#Preview {
    Study(angle: Angle(degrees: 45))
}
