//
//  RankingRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class RankingRequest: Request {
    var path: String = "/v2/users/experience_rank"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    var idToken: String?
    typealias Response = [RankingUser]
    
    func experience_rank() -> Self {
        return self
    }
    
    func experience_rank(weekly: Bool) -> Self {
        queryItems = [URLQueryItem(name: "weekly", value: String(true))]
        return self
    }
    
    func experience_rank(monthly: Bool) -> Self {
        queryItems = [URLQueryItem(name: "monthly", value: String(true))]
        return self
    }
}
