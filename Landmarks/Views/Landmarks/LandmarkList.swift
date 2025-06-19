//
//  LandmarkList.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/05.
//

import SwiftUI

struct LandmarkList: View {
    @Environment(ModelData.self) var modelData
    @State private var showFavoritesOnly = false
    
    var filteredLandmarks: [Landmark] {
        modelData.landmarks.filter { landmark in
            (!showFavoritesOnly || landmark.isFavorite)
        }
    }
    
    var body: some View {
        NavigationSplitView {
            //id: \.idがあることで各要素を一意に識別 IdentifiableがあればOK
            List {
                // $はBinding
                Toggle(isOn: $showFavoritesOnly) {
                    Text("Favorites only")
                }
                ForEach(filteredLandmarks) { landmark in
                    NavigationLink {
                        LandmarkDetail(landmark: landmark)
                    } label: {
                        LandmarkRow(landmark: landmark)
                    }
                }
            }
            .animation(.interactiveSpring, value: filteredLandmarks)
            .navigationTitle("Landmarks")
        } detail: {
            Text("Select a landmark")
        }
        
    }
}

#Preview {
    LandmarkList()
        .environment(ModelData())
}
