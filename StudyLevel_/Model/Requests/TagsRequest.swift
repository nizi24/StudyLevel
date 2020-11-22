//
//  TagRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class TagsRequest: Request {
    typealias Response = [Tag]
    var path: String = "/v2/time_reports/:time_report_id/tags"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func index(timeReportId: Int) -> Self {
        path = "/v2/time_reports/\(timeReportId)/tags"
        return self
    }
}
