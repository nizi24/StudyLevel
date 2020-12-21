//
//  NoticesRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/19.
//

import Foundation

class NoticesRequest: Request {
    var path: String = "/v2/users/:user_id/notices"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = [Notice]
    
    func index(userId: Int) -> Self {
        path = "/v2/users/\(userId)/notices"
        return self
    }
    
    func index(userId: Int, limit: Int) -> Self {
        path = "/v2/users/\(userId)/notices"
        queryItems = [URLQueryItem(name: "limit", value: "\(limit)")]
        return self
    }
    
    func index(userId: Int, offset: Int) -> Self {
        path = "/v2/users/\(userId)/notices"
        queryItems = [URLQueryItem(name: "offset", value: "\(offset)")]
        return self
    }
    
    func check(userId: Int, limit: Int) -> Self {
        path = "/v2/users/\(userId)/notices/check"
        queryItems = [URLQueryItem(name: "limit", value: String(limit))]
        return self
    }
}
