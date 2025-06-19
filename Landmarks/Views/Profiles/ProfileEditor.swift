//
//  ProfileEditor.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/11.
//

import SwiftUI

struct ProfileEditor: View {
    @Binding var profile: Profile
    
    var dateRange: ClosedRange<Date> {
        // Profile.goalDateから年単位で一年引く
        let min = Calendar.current.date(byAdding: .year, value: -1, to: profile.goalDate)!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: profile.goalDate)!
        return min...max
    }
    
    var body: some View {
        List {
            HStack {
                Text("Username")
                Spacer()
                TextField("Username", text: $profile.username)
                    .foregroundStyle(.secondary)
                // trailing右揃え
                    .multilineTextAlignment(.trailing)
            }
            Toggle(isOn: $profile.prefersNotifications) {
                Text("Enable Notifications")
            }
            // Picker はユーザーが選択できる UI
            // バインディング（$付き） を渡して、選ばれた値を profile.seasonalPhoto に反映させる
            Picker("Seasonal Photo", selection: $profile.seasonalPhoto) {
                ForEach(Profile.Season.allCases) { season in
                    // Text(...) → 表示用ラベル
                    // .tag(season) → Picker の選択値として、どの season を選んだかを特定する
                    Text(season.rawValue).tag(season)
                }
            }
            .pickerStyle(.automatic)
            // 日付のみ表示・選択できる（時刻は表示されない）
            DatePicker(selection: $profile.goalDate, in: dateRange, displayedComponents: .date) {
                Text("Goal Date")
            }
            .datePickerStyle(.wheel)
        }
    }
}

#Preview {
    // .constant 変更できない.defaultのプロフィール
    ProfileEditor(profile: .constant(.default))
}
