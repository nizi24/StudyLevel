//
//  ExperienceRecord.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

struct ExperienceRecord: Decodable {
    var id: Int
    var userId: Int
    var timeReportId: Int
    var experiencePoint: Int
    var bonusMultiplier: Double
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case timeReportId = "time_report_id"
        case experiencePoint = "experience_point"
        case bonusMultiplier = "bonus_multiplier"
    }
}
