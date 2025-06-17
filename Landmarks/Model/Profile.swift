//
//  Profile.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/11.
//

import Foundation

struct Profile {
    var username: String
    var prefersNotifications = true
    var seasonalPhoto = Season.winter
    // Date() というイニシャライザ（初期化子）を使うと、今の瞬間の日時 を表す Date インスタンスが生成
    var goalDate = Date()
    
    // 初期値を定義
    //キーワード default をプロパティ名として使うためのエスケープ記号
    static let `default` = Profile(username: "g_kumar")
    
    
    enum Season: String, CaseIterable, Identifiable {
        case spring = "🌷"
        case summer = "🌞"
        case autumn = "🍂"
        case winter = "☃️"
        
        
        var id: String { rawValue }
    }
}
