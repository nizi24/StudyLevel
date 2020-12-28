//
//  TagPage.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

struct TagPage: Decodable {
    var id: Int
    var name: String
    var createdAt: String
    var updatedAt: String
    var followerCount: Int
    var timeReportCount: Int
    var following: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case followerCount = "follower_count"
        case timeReportCount = "time_report_count"
        case following = "following?"
    }
}
