//
//  FollowRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class FollowRequest: Request {
    var path: String = "/v1/users/:id"
    var method: HTTPMethod = .post
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = Int
    
    func follow(userId: Int, currentUserId: Int) -> Self {
        path = "/v1/users/\(userId)/follow"
        let params = ["current_user_id": currentUserId]
        do {
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
    
    func unfollow(userId: Int, currentUserId: Int) -> Self {
        path = "/v1/users/\(userId)/unfollow"
        method = .delete
        let params = ["current_user_id": currentUserId]
        do {
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
    
    func follow(tagId: Int, currentUserId: Int) -> Self {
        path = "/v1/tags/\(tagId)/follow"
        let params = ["user_id": currentUserId]
        do {
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
    
    func unfollow(tagId: Int, currentUserId: Int) -> Self {
        path = "/v1/tags/\(tagId)/unfollow"
        method = .delete
        let params = ["user_id": currentUserId]
        do {
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
}
