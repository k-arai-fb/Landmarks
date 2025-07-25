//
//  FeatureCard.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/17.
//

import SwiftUI

// View型
struct FeatureCard: View {
    var landmark: Landmark
    
    
    var body: some View {
        // オプショナルチェーン この値が存在するならその先に進んで、そうでなければ nil のままにする
        landmark.featureImage?
            .resizable()
            .overlay {
                TextOverlay(landmark: landmark)
            }
    }
}


struct TextOverlay: View {
    var landmark: Landmark
    
    
    var gradient: LinearGradient {
        .linearGradient(
            Gradient(colors: [.black.opacity(0.6), .black.opacity(0)]),
            startPoint: .bottom,
            endPoint: .center)
    }
    
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            gradient
            VStack(alignment: .leading) {
                Text(landmark.name)
                    .font(.title)
                    .bold()
                Text(landmark.park)
            }
            .padding()
        }
        .foregroundStyle(.white)
    }
}


#Preview {
    FeatureCard(landmark: ModelData().features[0])
        .aspectRatio(3 / 2, contentMode: .fit)
    //TextOverlay(landmark: ModelData().features[0])
}
