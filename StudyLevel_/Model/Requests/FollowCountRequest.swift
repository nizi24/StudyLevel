//
//  FollowCountRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class FollowCountRequest: Request {
    typealias Response = Int
    var path: String = "/v2/users"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func followingCount(id: Int) -> Self {
        path = "/v2/users/\(id)/following_count"
        method = .get
        return self
    }
    
    func followerCount(id: Int) -> Self {
        path = "/v2/users/\(id)/follower_count"
        method = .get
        return self
    }
}
