//
//  ExperienceRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

class ExperienceRequest: Request {
    typealias Response = Experience
    var path = "/v2/:user_id/experience"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    
    func show(userId: Int) -> Self {
        path = "/v2/users/\(userId)/experience"
        method = .get
        return self
    }
}
