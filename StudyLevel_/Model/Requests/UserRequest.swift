//
//  UserRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation

class UserRequest: Request {
    typealias Response = User
    var path: String = ""
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func currentUser(uid: String) -> Self {
        path = "/v2/users"
        method = .get
        queryItems = [URLQueryItem(name: "uid", value: uid)]
        return self
    }
    
    func create(name: String, email: String, uid: String) -> Self {
        path = "/v2/users"
        method = .post
        do {
            let params = ["user": ["name": name, "email": email, "uid": uid]]
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
}
