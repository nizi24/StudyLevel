//
//  isFollowingRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class IsFollowingRequest: Request {
    var path: String = "/v2/users/:user_id/is_following"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = Bool
    
    func is_following(targetUserId: Int, currentUserId: Int) -> Self {
        path = "/v2/users/\(targetUserId)/is_following"
        queryItems = [URLQueryItem(name: "current_user_id", value: String(currentUserId))]
        return self
    }
}
