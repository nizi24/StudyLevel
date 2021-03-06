//
//  AvatarURL.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

class AvatarRequest: Request {
    typealias Response = String?
    var path = "/v2/users/:id/avatar_url"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func avatarURL(userId: Int) -> Self {
        path = "/v2/users/\(userId)/avatar_url"
        method = .get
        return self
    }
}
