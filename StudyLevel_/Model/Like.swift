//
//  Like.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/05.
//

import Foundation

struct Like: Decodable {
    var likeableType: String
    var likeableId: Int
    var userId: Int
    
    enum CodingKeys: String, CodingKey {
        case likeableType = "likeable_type"
        case likeableId = "likeable_id"
        case userId = "user_id"
    }
}

enum LikeableType: String {
    case timeReport = "TimeReport"
    case comment = "Comment"
}
