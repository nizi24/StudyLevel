//
//  WeeklyTargetExperienceRecord.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

struct WeeklyTargetExperienceRecord: Decodable {
    var id: Int
    var weeklyTargetId: Int
    var userId: Int
    var experiencePoint: Int
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case weeklyTargetId = "weekly_target_id"
        case userId = "user_id"
        case experiencePoint = "experience_point"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
