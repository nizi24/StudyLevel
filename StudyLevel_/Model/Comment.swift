//
//  Comment.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

struct Comment: Decodable {
    var id: Int
    var timeReportId: Int
    var userId: Int
    var content: String
    var createdAt: String
    var updatedAt: String
    var likesCount: Int
    var creator: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case timeReportId = "time_report_id"
        case userId = "user_id"
        case content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case likesCount = "likes_count"
        case creator = "user"
    }
}
