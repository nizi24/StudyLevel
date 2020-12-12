//
//  SearchUserRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class SearchUserRequest: Request {
    var path: String = "/v2/users/search"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = [SearchUser]
    
    func search(word: String) -> Self {
        queryItems = [URLQueryItem(name: "word", value: word)]
        return self
    }
}
