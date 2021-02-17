//
//  CommentRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/04.
//

import Foundation

class CommentRequest: Request {
    var path: String = "/v1/comments"
    var method: HTTPMethod = .post
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    var idToken: String?
    typealias Response = Comment
    
    func create(userId: Int, timeReportId: Int, content: String, idToken: String) -> Self {
        self.idToken = idToken
        let params = ["comment": ["user_id": userId, "time_report_id": timeReportId, "content": content]]
        do {
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
    
    func destroy(commentId: Int, idToken: String) -> Self {
        self.idToken = idToken
        path = "/v1/comments/\(commentId)"
        method = .delete
        return self
    }
}
