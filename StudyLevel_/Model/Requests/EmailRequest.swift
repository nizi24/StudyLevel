//
//  EmailRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation

class EmailRequest: Request {
    var path: String = "/v2/users/email"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    var idToken: String?
    typealias Response = String
    
    func getEmail(uid: String, idToken: String) -> Self {
        self.idToken = idToken
        queryItems = [URLQueryItem(name: "uid", value: uid)]
        return self
    }
}
