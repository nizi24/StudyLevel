//
//  ScreenNameAlreadyUsedRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import Foundation

class AlreadyUsedRequest: Request {
    var path: String = "/v2/users/screen_name_already_used"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var idToken: String?
    var contentType: String?
    typealias Response = Bool
    
    func screenNameAlreadyUsed(userId: Int, screenName: String) -> Self {
        path = "/v2/users/\(userId)/screen_name_already_used"
        queryItems = [URLQueryItem(name: "screen_name", value: screenName)]
        return self
    }
    
    func emailAlreadyUsed(email: String) -> Self {
        path = "/v2/users/email_already_used"
        queryItems = [URLQueryItem(name: "email", value: email)]
        return self
    }
    
    func emailAlreadyUsed(userId: Int, email: String) -> Self {
        path = "/v2/users/\(userId)/email_already_used"
        queryItems = [URLQueryItem(name: "email", value: email)]
        return self
    }
}
