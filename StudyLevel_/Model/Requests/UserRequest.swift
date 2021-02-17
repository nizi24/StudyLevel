//
//  UserRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import SwiftUI

class UserRequest: Request {
    typealias Response = User
    var path: String = ""
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var idToken: String?
    var contentType: String?
    
    func currentUser(uid: String) -> Self {
        path = "/v2/users"
        method = .get
        queryItems = [URLQueryItem(name: "uid", value: uid)]
        return self
    }
    
    func show(id: Int) -> Self {
        path = "/v2/users/\(id)"
        method = .get
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
    
    func update(userId: Int, name: String, screenName: String, profile: String, idToken: String) -> Self {
        self.idToken = idToken
        path = "/v2/users/\(userId)"
        method = .patch
        do {
            let params = ["user": ["name": name, "screen_name": screenName, "profile": profile]]
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
    
    func update(userId: Int, email: String, idToken: String) -> Self {
        self.idToken = idToken
        path = "/v2/users/\(userId)"
        method = .patch
        do {
            let params = ["user": ["email": email]]
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
    
    func update_avatar(userId: Int, image: UIImage, idToken: String) -> Self {
        self.idToken = idToken
        path = "/v2/users/\(userId)/update_avatar"
        method = .patch
        contentType = "multipart/form-data"
        let imageData = image.jpegData(compressionQuality: 0.2)
        body = httpBody(imageData!, fileName: "icon")
        return self
    }
    
    private func httpBody(_ fileAsData: Data, fileName: String) -> Data {
        let boundary = "----BoundaryZLdHZy8HNaBmUX0d"
        var data = "--\(boundary)\r\n".data(using: .utf8)!
        data += "Content-Disposition: form-data; name=\"file\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!
        data += "Content-Type: image/jpeg\r\n".data(using: .utf8)!
        data += "\r\n".data(using: .utf8)!
        data += fileAsData
        data += "\r\n".data(using: .utf8)!
        data += "--\(boundary)--\r\n".data(using: .utf8)!
        return data
    }
}
