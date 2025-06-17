//
//  ProfileHost.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/11.
//

import SwiftUI

struct ProfileHost: View {
    // SwiftUI が用意している 編集モード状態（.inactive or .active） を取得する
    // EditButton() を押すと、この値が自動的に変化する
    // editMode?.wrappedValue で現在の状態を取得
    @Environment(\.editMode) var editMode
    @Environment(ModelData.self) var modelData
    // 編集中の一時保存用のプロファイル
    @State private var draftProfile = Profile.default
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                // 編集キャンセル処理
                if editMode?.wrappedValue == .active {
                    // role: .cancel を指定すると、iOSのアクセシビリティや UI 上で「キャンセル操作」として扱われる　意味づけ　アクセシビリティ対応
                    Button("Cancel", role: .cancel) {
                        draftProfile = modelData.profile
                        // 編集モードを「終了」に設定
                        // .animation() を使うことで、編集モードの切り替えにアニメーションを付けて切り替えられる
                        editMode?.animation().wrappedValue = .inactive
                    }
                }
                Spacer()
                // 状態変化　Doneにへんか
                EditButton()
            }

            if editMode?.wrappedValue == .inactive {
                ProfileSummary(profile: modelData.profile)
            } else {
                ProfileEditor(profile: $draftProfile)
                // 編集ビューが表示される直前に、現在のプロフィールをコピーして draftProfile に保存
                    .onAppear {
                        draftProfile = modelData.profile
                    }
                // 編集ビューが閉じられるとき（つまり編集が完了したとき）に、                編集内容（draftProfile）を 本物のデータ（modelData.profile）に反映
                    .onDisappear {
                        modelData.profile = draftProfile
                    }
            }
        }
        .padding()
    }
}

#Preview {
    ProfileHost()
        .environment(ModelData())
}
