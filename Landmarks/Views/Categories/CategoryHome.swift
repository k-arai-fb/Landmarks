//
//  CategoryHome.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/11.
//

import SwiftUI


struct CategoryHome: View {
    @Environment(ModelData.self) var modelData
    @State private var showingProfile = false
    
    
    var body: some View {
        NavigationSplitView {
            List {
                modelData.features[0].image
                    .resizable()
                    .scaledToFill()
                // ビューのサイズを指定する。切り取られない。
                    .frame(height: 200)
                // frameで指定した大きさに切り取る。
                    .clipped()
                // セルの左右の余白を制御
                    .listRowInsets(EdgeInsets(top: 10, leading: 0, bottom: 0, trailing: 0))
                
                // 辞書型のキーを.sortedでアルファベット順に並べ替え
                // \.self 各キー自体をIDとして使っている
                ForEach(modelData.categories.keys.sorted(), id: \.self) { key in
                    CategoryRow(categoryName: key, items: modelData.categories[key]!)
                }
                .listRowInsets(EdgeInsets())
            }
            .listStyle(.inset)
            .navigationTitle("Featured")
            .toolbar {
                Button {
                    // Bool 型の状態を反転 → true
                    showingProfile.toggle()
                } label: {
                    Label("User Profile", systemImage: "person.crop.circle")
                }
            }
            //下からOver wrap　fullScreenCoverは閉じ方を明示
            .sheet(isPresented: $showingProfile) {
                ProfileHost()
                    .environment(modelData)
            }
            
        } detail: {
            Text("Select a Landmark")
        }
    }
}


#Preview {
    CategoryHome()
        .environment(ModelData())
}



