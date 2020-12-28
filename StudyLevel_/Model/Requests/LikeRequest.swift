//
//  LikeRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/05.
//

import Foundation

class LikeRequest: Request {
    var path: String = "/v1/like"
    var method: HTTPMethod = .post
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = Like
    
    func create(likeableType: String, likeableId: Int, userId: Int) -> Self {
        let params = ["like": ["likeable_type": likeableType, "likeable_id": likeableId, "user_id": userId] ]
        do {
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
    
    func delete(likeableType: String, likeableId: Int, userId: Int) -> Self {
        path = "/v2/likes/delete"
        method = .post
        let params = ["like": ["likeable_type": likeableType, "likeable_id": likeableId, "user_id": userId] ]
        do {
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
}
