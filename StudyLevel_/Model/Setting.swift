//
//  Setting.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation

struct Setting: Decodable {
    var id: Int
    var userId: Int
    var commentNotice: Bool
    var commentLikeNotice: Bool
    var timeReportLikeNotice: Bool
    var followNotice: Bool
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case commentNotice = "comment_notice"
        case commentLikeNotice = "comment_like_notice"
        case timeReportLikeNotice = "time_report_like_notice"
        case followNotice = "follow_notice"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
