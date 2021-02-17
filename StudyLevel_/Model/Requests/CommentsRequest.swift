//
//  CommentsRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

class CommentsRequest: Request {
    var path: String = "/v1/time_reports/:time_report_id/comments"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var idToken: String?
    var contentType: String?
    typealias Response = [Comment]
    
    func index(timeReportId: Int) -> Self {
        path = "/v1/time_reports/\(timeReportId)/comments"
        return self
    }
}
