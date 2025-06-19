//
//  ModelData.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/05.
//

import Foundation

@Observable
class ModelData {
    var landmarks: [Landmark] = load("landmarkData.json")
    var hikes: [Hike] = load("hikeData.json")
    var profile = Profile.default
    var features: [Landmark] {
        landmarks.filter { $0.isFeatured }
    }
    
    var categories: [String: [Landmark]] {
        //配列をある条件(キー)でグループ化し、辞書にする
        Dictionary(
            grouping: landmarks,
            // rawValueはenumに割り当てられた元の値
            by: { $0.category.rawValue }
        )
    }
    
}



func load<T: Decodable>(_ filename: String) -> T {
    let data: Data
    
    //Bundle.mainはアプリに含まれるリソースファイルにアクセスするための入り口　withExtensionは拡張子
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }
    
    //バイナリデータに変換
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }
    
    //構造体にデコード
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
