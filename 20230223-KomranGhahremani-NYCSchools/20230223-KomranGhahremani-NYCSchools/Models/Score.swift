//
//  Score.swift
//  20230223-KomranGhahremani-NYCSchools
//
//  Created by Komran Ghahremani on 2/26/23.
//

import Foundation

struct Score: Codable {
    var dbn: String
    var reading: String
    var math: String
    var writing: String
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case reading = "sat_critical_reading_avg_score"
        case math = "sat_math_avg_score"
        case writing = "sat_writing_avg_score"
    }
}
