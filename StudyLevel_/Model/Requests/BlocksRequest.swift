//
//  BlocksRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/28.
//

import Foundation

class BlocksRequest: Request {
    var path: String = "/v2/users/:user_id/blocks"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = [Block]
    
    func index(userId: Int) -> Self {
        path = "/v2/users/\(userId)/blocks"
        return self
    }
}
