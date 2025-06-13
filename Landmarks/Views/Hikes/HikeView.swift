/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view displaying information about a hike, including an elevation graph.
*/

import SwiftUI

//SwiftUI における ビューの出現／消失に使う「見た目の変化」＝アニメーションのルール を定義する型
extension AnyTransition {
    static var moveAndFade: AnyTransition {
        .asymmetric(
            //
            insertion: .move(edge: .trailing).combined(with: .opacity),
            removal: .scale.combined(with: .opacity)
        )
    }
}
struct HikeView: View {
    var hike: Hike
    @State private var showDetail = false

    var body: some View {
        VStack {
            HStack {
                HikeGraph(hike: hike, path: \.elevation)
                    .frame(width: 50, height: 30)

                VStack(alignment: .leading) {
                    Text(hike.name)
                        .font(.headline)
                    Text(hike.distanceText)
                }

                Spacer()

                Button {
                    //状態の変更にアニメーションをつけるためのトリガー
                    withAnimation {
                        showDetail.toggle()
                    }
                } label: {
                    Label("Graph", systemImage: "chevron.right.circle")
                        .labelStyle(.iconOnly)
                        .imageScale(.large)
                        .rotationEffect(.degrees(showDetail ? 90 : 0))
                        .scaleEffect(showDetail ? 1.5 : 1)
                        .padding()
                }
            }

            if showDetail {
                HikeDetail(hike: hike)
                    //表示/非表示の際にトランジション効果が適用される
                    .transition(.moveAndFade)
            }
        }
    }
}

#Preview {
    VStack {
        HikeView(hike: ModelData().hikes[0])
            .padding()
        Spacer()
    }
}
