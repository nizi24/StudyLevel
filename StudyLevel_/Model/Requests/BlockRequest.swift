//
//  BlockRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/28.
//

import Foundation

class BlockRequest: Request {
    var path: String = "/v2/users/:user_id/blocks"
    var method: HTTPMethod = .post
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = Int
    
    func create(currentUserId: Int, userId: Int) -> Self {
        path = "/v2/users/\(userId)/blocks"
        do {
            let params = ["current_user_id": currentUserId]
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
    
    func delete(currentUserId: Int, userId: Int) -> Self {
        path = "/v2/users/\(userId)/blocks/1"
        method = .delete
        do {
            let params = ["current_user_id": currentUserId]
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
}
