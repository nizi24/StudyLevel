//
//  MainTagsRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/14.
//

import Foundation

class MainTagsRequest: Request {
    var path: String = "/v2/users/:id/main_tags"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = [MainTag]
    
    func mainTags(userId: Int) -> Self {
        path = "/v2/users/\(userId)/main_tags"
        return self
    }
}
