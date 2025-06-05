//
//  LandmarksApp.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/04.
//

import SwiftUI

@main
struct LandmarksApp: App {
    @State private var modelData = ModelData()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
