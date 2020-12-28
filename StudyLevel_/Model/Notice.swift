//
//  Notice.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/19.
//

import Foundation

struct Notice: Decodable {
    var id: Int
    var actionUserId: Int
    var receivedUserId: Int
    var noticeableType: String
    var noticeableId: Int
    var likeType: String?
    var timeReportId: Int?
    var checked: Bool
    var createdAt: String
    var updatedAt: String
    var screenName: String
    var actionUser: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case actionUserId = "action_user_id"
        case receivedUserId = "received_user_id"
        case noticeableType = "noticeable_type"
        case noticeableId = "noticeable_id"
        case likeType = "like_type"
        case timeReportId = "time_report_id"
        case checked
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case screenName = "screen_name"
        case actionUser = "action_user"
    }
}
