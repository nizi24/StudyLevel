//
//  WeeklyTargetsRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

class WeeklyTargetsRequest: Request {
    var path: String = "/v2/users/:user_id/weekly_targets"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    var idToken: String?
    typealias Response = [WeeklyTarget]
    
    func index(userId: Int) -> Self {
        path = "/v2/users/\(userId)/weekly_targets"
        return self
    }
}
