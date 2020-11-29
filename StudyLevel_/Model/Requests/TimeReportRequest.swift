//
//  TimeReportRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/28.
//

import Foundation

class TimeReportRequest: Request {
    var path: String = "/v2/time_reports"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    typealias Response = TimeReport
    
    func create(studyTime: String, studyDate: Date, memo: String, tags: [String], userId: Int) -> Self {
        path = "/v2/time_reports"
        method = .post
        do {
            let tags = ["tags": tags.map { ["text": $0] }]
            let params: [String : Any] = ["time_report": ["study_time": studyTime, "study_date": "\(studyDate)", "memo": memo],
                          "tags": tags, "user_id": userId]
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError("Encoding failed")
        }
        return self
    }
}
