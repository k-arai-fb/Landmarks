/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
The elevation, heart rate, and pace of a hike plotted on a graph.
*/

import SwiftUI

extension Animation {
    static func ripple(index: Int) -> Animation {
        //バネのように弾むアニメーション
        Animation.spring(dampingFraction: 0.5)
            .speed(2)
            .delay(0.03 * Double(index))
    }
}


struct HikeGraph: View {
    var hike: Hike
    //Hike.Observation 型の中の ある1つのプロパティ を参照して、それが Range<Double> 型であることを保証する “参照のしくみ” を保持する変数
    //path = \Hike.Observation.elevation
    //                ポインタ           参照する値の型
    var path: KeyPath<Hike.Observation, Range<Double>>

    var color: Color {
        switch path {
        case \.elevation:
            return .gray
        case \.heartRate:
            //hue:0.0~1.0（0は赤、0.33が緑、0.66が青）
            //saturation: 色の鮮やかさ（0に近いほどグレー）
            //brightness: 明るさ（1.0で明るい、0.0で黒）
            return Color(hue: 0, saturation: 0.5, brightness: 0.7)
        case \.pace:
            return Color(hue: 0.66, saturation: 0.4, brightness: 0.7)
        default:
            return .black
        }
    }

    var body: some View {
        let data = hike.observations
        //.lazy: 遅延評価を使ってメモリ効率をよくする overallRangesから要素を取り出すときに初めて処理される
        let overallRange = rangeOfRanges(data.lazy.map { $0[keyPath: path] })
        let maxMagnitude = data.map { magnitude(of: $0[keyPath: path]) }.max()!
        let heightRatio = 1 - CGFloat(maxMagnitude / magnitude(of: overallRange))

        //ビューのサイズを取得できる特殊なビュー
        return GeometryReader { proxy in
            HStack(alignment: .bottom, spacing: proxy.size.width / 120) {
                //.enumerated [(offset: Int, element: Element)]
                //enumerated() の結果は EnumeratedSequence という特殊なシーケンス型
                ForEach(Array(data.enumerated()), id: \.offset) { index, observation in
                    GraphCapsule(
                        index: index,
                        color: color,
                        height: proxy.size.height,
                        range: observation[keyPath: path],
                        overallRange: overallRange
                    )
                }
                .offset(x: 0, y: proxy.size.height * heightRatio)
            }
        }
    }
}
//rangesは配列やリストなど「繰り返し可能なコレクション型」である
//<C: Collection> というのは Swift における「ジェネリクス（Generics）＋ プロトコル制約」の組み合わせです。これは：「引数として、どんなコレクションでも使えるように汎用化する書き方」配列以外でも使える
func rangeOfRanges<C: Collection>(_ ranges: C) -> Range<Double>
    //ranges の各要素は Range<Double> 型でなければならない
    where C.Element == Range<Double> {
    guard !ranges.isEmpty else { return 0..<0 }
    let low = ranges.lazy.map { $0.lowerBound }.min()!
    let high = ranges.lazy.map { $0.upperBound }.max()!
    return low..<high
}

func magnitude(of range: Range<Double>) -> Double {
    range.upperBound - range.lowerBound
}

#Preview {
    let hike = ModelData().hikes[0]
    return Group {
        HikeGraph(hike: hike, path: \.elevation)
            .frame(height: 200)
        HikeGraph(hike: hike, path: \.heartRate)
            .frame(height: 200)
        HikeGraph(hike: hike, path: \.pace)
            .frame(height: 200)
    }
}
