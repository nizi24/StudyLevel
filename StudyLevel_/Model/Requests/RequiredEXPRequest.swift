//
//  RequiredEXPRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation


class RequiredEXPRequest: Request {
    typealias Response = RequiredEXP
    var path = "/v2/required_exp"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    
    func show(level: Int) -> Self {
        queryItems = [URLQueryItem(name: "level", value: String(level))]
        return self
    }
}
