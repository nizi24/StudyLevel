//
//  RankingUser.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

struct RankingUser: Decodable, Hashable {
    var id: Int
    var name: String
    var screenName: String
    var exp: Int
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case exp
        case avatarURL = "avatar_url"
    }
}
