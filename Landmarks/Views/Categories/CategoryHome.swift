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
                // 画像テキストのカードに変換したものを渡す
                // pages:Array<FeatureCard>([FutureCard])
                PageView(pages: modelData.features.map { FeatureCard(landmark: $0) })
                    .listRowInsets(EdgeInsets())
                
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



