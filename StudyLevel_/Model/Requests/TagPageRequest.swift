//
//  TagPageRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class TagPageRequest: Request {
    var path: String = "/v2/tags/:id"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    var idToken: String?
    typealias Response = TagPage
    
    func show(tagId: Int, currentUserId: Int) -> Self {
        path = "/v2/tags/\(tagId)"
        queryItems = [URLQueryItem(name: "current_user_id", value: String(currentUserId))]
        return self
    }
}
