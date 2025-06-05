//
//  ContentView.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/04.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

#Preview {
    ContentView()
        .environment(ModelData())
}
