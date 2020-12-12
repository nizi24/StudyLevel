//
//  TagSearchRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class TagSearchRequest: Request {
    var path: String = "/v2/tags/search"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = [SearchTag]
    
    func search(name: String) -> Self {
        queryItems = [URLQueryItem(name: "name", value: name)]
        return self
    }
    
}
