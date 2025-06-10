//
//  Hike.swift
//  Landmarks
//
//  Created by k.arai on 2025/06/06.
//

import Foundation

struct Hike: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var distance: Double
    var difficulty: Int
    var observations: [Observation]
    
    //距離を文字列に変換するためのクラス MeasurementFormatterより軽量
    static var formatter = LengthFormatter()
    
    
    var distanceText: String {
        Hike.formatter
            //distanceをキロメートルの文字列に変換
            .string(fromValue: distance, unit: .kilometer)
    }
    
    
    struct Observation: Codable, Hashable {
        var distanceFromStart: Double
        
        
        var elevation: Range<Double>
        var pace: Range<Double>
        var heartRate: Range<Double>
    }
}

