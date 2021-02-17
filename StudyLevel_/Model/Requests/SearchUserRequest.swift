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
    var contentType: String?
    var idToken: String?
    typealias Response = [SearchUser]
    
    func search(word: String) -> Self {
        queryItems = [URLQueryItem(name: "word", value: word)]
        return self
    }
    
    func following(userId: Int) -> Self {
        path = "/v2/users/\(userId)/following"
        return self
    }
    
    func followers(userId: Int) -> Self {
        path = "/v2/users/\(userId)/followers"
        return self
    }

}
