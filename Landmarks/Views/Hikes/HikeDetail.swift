/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing the details for a hike.
*/

import SwiftUI


/// tupleではなくenumを採用したHikeDetailの例
struct HikeDetail: View {
    let hike: Hike
    //Hike.Observation 型の elevation プロパティを参照する
    @State var dataToShow = \Hike.Observation.elevation

    // tupleはシンプルに使うならいいけど複雑化するならenumとかstructとかで構造化したほうがいい
    var buttons: [(title: String, path: WritableKeyPath<Hike.Observation, Range<Double>>)] = [
        ("Elevation", \Hike.Observation.elevation),
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace),
    ]
    
    // どんなボタンでも、この情報さえ用意したら表示していい、っていう設計ならstruct
    struct HikeButton {
        let tilte: String
        let path: WritableKeyPath<Hike.Observation, Range<Double>>
    }
    
    // あらかじめボタンの種類が決まっているなら、enum。
    // 今回は、Hikeに対してelevation/heartRate/pace以外ありえない設計だったので、enumを採用
    enum Buttons: CaseIterable {
        case elevation, heartRate, pace
        
        var title: String {
            switch self {
            case .elevation:
                return "Elevation"
            case .heartRate:
                return "Heart Rate"
            case .pace:
                return "Pace"
            }
        }
        
        var subtitle: String {
            switch self {
            case .elevation:
                return "in meters"
            case .heartRate:
                return "beats per minute"
            case .pace:
                return "minutes per mile"
            }
        }
        
        var path: WritableKeyPath<Hike.Observation, Range<Double>> {
            switch self {
            case .elevation:
                return \Hike.Observation.elevation
            case .heartRate:
                return \Hike.Observation.heartRate
            case .pace:
                return \Hike.Observation.pace
            }
        }
    }

    var body: some View {
        VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
                .transition(.moveAndFade)

            HStack(spacing: 25) {
                ForEach(Buttons.allCases, id: \.title) { value in
                    Button {
                        //value は ("Elevation",\Hike.Observation.elevation)
                        withAnimation {
                            dataToShow = value.path
                        }
                        
                    } label: {
                        Text(value.title)
                            .font(.system(size: 15))
                            .foregroundStyle(value.path == dataToShow
                                ? .gray
                                : .accentColor)
                            .animation(nil)
                    }
                }
            }
        }
    }
}

#Preview {
    HikeDetail(hike: ModelData().hikes[0])
}
