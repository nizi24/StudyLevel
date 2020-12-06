//
//  LikesRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/05.
//

import Foundation

class LikesRequest: Request {
    var path: String = "/v2/users/:user_id/likes"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = [Like]
    
    func index(userId: Int) -> Self {
        path = "/v2/users/\(userId)/likes"
        return self
    }
}
