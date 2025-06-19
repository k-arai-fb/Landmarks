//
//  BadgeBackground.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/06.
//

import SwiftUI

struct BadgeBackground: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                var width: CGFloat = min(geometry.size.width, geometry.size.height)
                let height = width
                //x方向に小さく
                let xScale: CGFloat = 0.83
                //小さくしてズレた分中央に戻す
                let xOffset = (width * (1.0 - xScale)) / 2.0
                
                width *= xScale
                //始点へ移動
                path.move(
                    to: CGPoint(
                        x: width * 0.95 + xOffset,
                        y: height * (0.20 + HexagonParameters.adjustment)
                    )
                )
                
                
                HexagonParameters.segments.forEach { segment in
                    //直線
                    path.addLine(
                        to: CGPoint(
                            x: width * segment.line.x + xOffset,
                            y: height * segment.line.y
                        )
                    )
                    
                    //カーブ
                    path.addQuadCurve(
                        to: CGPoint(
                            x: width * segment.curve.x + xOffset,
                            y: height * segment.curve.y
                        ),
                        control: CGPoint(
                            x: width * segment.control.x + xOffset,
                            y: height * segment.control.y
                        )
                    )
                }
            }
            //グラデーション
            .fill(.linearGradient(
                Gradient(colors: [Self.gradientStart, Self.gradientEnd]),
                //開始終了位置の指定
                startPoint: UnitPoint(x: 0.3, y: 0.3),
                endPoint: UnitPoint(x: 0.7, y: 0.7)
            ))
        }
        //表示領域
        .aspectRatio(1, contentMode: .fit)
    }
    static let gradientStart = Color(red: 239.0 / 255, green: 120.0 / 255, blue: 221.0 / 255)
    static let gradientEnd = Color(red: 239.0 / 255, green: 172.0 / 255, blue: 120.0 / 255)
}
#Preview {
    BadgeBackground()
}
