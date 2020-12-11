//
//  ExperienceRecordRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class ExperienceRecordRequest: Request {
    typealias Response = ExperienceRecord
    var path: String = "/v2/time_reports/:time_report_id/experience_records"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    
    func show(timeReportId: Int) -> Self {
        path = "/v2/time_reports/\(timeReportId)/experience_records"
        return self
    }
}
