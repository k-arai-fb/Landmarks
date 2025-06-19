//
//  Landmark.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/04.
//

import Foundation
import SwiftUI
import CoreLocation

struct Landmark: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String
    var city: String
    var isFeatured: Bool
    var isFavorite: Bool
    
    //カテゴリーは三つの選択肢を持つ型
    var category: Category
    //enum列挙型　選択肢の型を定義
    //CaseIterable 自動で全てのケースを.allCaseで取得可能
    //Codable JSON などに変換できるようになる（保存・通信で使う）
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
    
    private var imageName: String
    var image: Image {
        Image(imageName)
    }
    
    // オプショナル　画像がない可能性があるから
    var featureImage: Image? {
        isFeatured ? Image(imageName + "_feature") : nil
    }
    
    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }
    
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
