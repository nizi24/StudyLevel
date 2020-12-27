//
//  SettingRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation

class SettingRequest: Request {
    var path: String = "/v1/users/:user_id/setting"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = Setting
    
    func edit(userId: Int) -> Self {
        path = "/v1/users/\(userId)/setting/edit"
        return self
    }
    
    func update(userId: Int, commentNotice: Bool, commentLikeNotice: Bool, timeReportLikeNotice: Bool, followNotice: Bool) -> Self {
        path = "/v1/users/\(userId)/setting"
        method = .patch
        let params = ["setting": ["comment_notice": commentNotice, "comment_like_notice": commentLikeNotice,
                                  "time_report_like_notice": timeReportLikeNotice, "follow_notice": followNotice]]
        do {
            body = try JSONEncoder().encode(params)
        } catch {
            fatalError()
        }
        return self
    }
}
