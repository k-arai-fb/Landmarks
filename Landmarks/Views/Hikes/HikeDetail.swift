/*
See the LICENSE.txt file for this sample’s licensing information.

Abstract:
A view showing the details for a hike.
*/

import SwiftUI

struct HikeDetail: View {
    let hike: Hike
    //Hike.Observation 型の elevation プロパティを参照する
    @State var dataToShow = \Hike.Observation.elevation

    var buttons = [
        ("Elevation", \Hike.Observation.elevation),
        ("Heart Rate", \Hike.Observation.heartRate),
        ("Pace", \Hike.Observation.pace)
    ]

    var body: some View {
        VStack {
            HikeGraph(hike: hike, path: dataToShow)
                .frame(height: 200)
                .transition(.moveAndFade)

            HStack(spacing: 25) {
                ForEach(buttons, id: \.0) { value in
                    Button {
                        //value は ("Elevation",\Hike.Observation.elevation)
                        withAnimation {
                            dataToShow = value.1
                        }
                        
                    } label: {
                        Text(value.0)
                            .font(.system(size: 15))
                            .foregroundStyle(value.1 == dataToShow
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
