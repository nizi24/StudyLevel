//
//  User.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import UIKit

struct User: Decodable {
    var id: Int
    var name: String
    var screenName: String
    var createdAt: String
    var updatedAt: String
    var profile: String?
    var guest: Bool
    var avatarURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile
        case guest
        case avatarURL = "avatar_url"
    }    
}
