//
//  WeeklyTargetRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation

class WeeklyTargetRequest: Request {
    var path: String = "/v2/users/:user_id/weekly_targets"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = WeeklyTarget
    
    func show(userId: Int) -> Self {
        path = "/v2/users/\(userId)/weekly_target"
        return self
    }
}
