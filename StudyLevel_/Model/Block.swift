//
//  Block.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/28.
//

import Foundation

struct Block: Decodable {
    var id: Int
    var blockerId: Int
    var blockedId: Int
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case blockerId = "blocker_id"
        case blockedId = "blocked_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
