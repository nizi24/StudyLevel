//
//  WeeklyTarget.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation

struct WeeklyTarget: Decodable {
    var id: Int
    var userId: Int
    var startDate: String
    var endDate: String
    var achieve: Bool
    var createdAt: String
    var updatedAt: String
    var checked: Bool
    var targetTime: String
    var progress: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case startDate = "start_date"
        case endDate = "end_date"
        case achieve
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case checked
        case targetTime = "target_time"
        case progress
    }    
}
