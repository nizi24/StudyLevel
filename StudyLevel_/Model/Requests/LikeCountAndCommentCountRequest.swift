//
//  LikeCountAndCommentCountRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class LikeCountAndCommentCountRequest: Request {
    var path: String = "/v2/time_reports/:time_report_id"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = Int
    
    func likeCount(timeReportId: Int) -> Self {
        path = "/v2/time_reports/\(timeReportId)/likes_count"
        return self
    }
    
    func commentCount(timeReportId: Int) -> Self {
        path = "/v2/time_reports/\(timeReportId)/comments_count"
        return self
    }
}
