//
//  TimeReportsRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class TimeReportsRequest: Request {
    typealias Response = [TimeReport]
    var path: String = "/v2/users/:user_id/time_reports"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func index(userId: Int) -> Self {
        path = "/v2/users/\(userId)/time_reports"
        return self
    }
    
    func index(userId: Int, offset: Int) -> Self {
        path = "/v2/users/\(userId)/time_reports"
        queryItems = [URLQueryItem(name: "offset", value: String(offset))]
        return self
    }
    
    func index(userId: Int, limit: Int) -> Self {
        path = "/v2/users/\(userId)/time_reports"
        queryItems = [URLQueryItem(name: "limit", value: String(limit))]
        return self
    }
}
