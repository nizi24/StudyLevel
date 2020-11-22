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
}
