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
    var contentType: String?
    typealias Response = TimeReport
    
    func show(timeReportId: Int) -> Self {
        method = .get
        path = "/v2/time_reports/\(timeReportId)"
        return self
    }
    
    func create(studyTime: String, studyDate: Date, memo: String, tags: [String], userId: Int) -> Self {
        method = .post
        path = "/v2/time_reports"
        return processingPostTimeReportSchema(studyTime: studyTime, studyDate: studyDate, memo: memo, tags: tags, userId: userId)
    }
    
    func update(timeReportId: Int, studyTime: String, studyDate: Date, memo: String, tags: [String], userId: Int) -> Self {
        method = .patch
        path = "/v2/time_reports/\(timeReportId)"
        return processingPostTimeReportSchema(studyTime: studyTime, studyDate: studyDate, memo: memo, tags: tags, userId: userId)
    }
    
    func delete(timeReportId: Int) -> Self {
        path = "/v2/time_reports/\(timeReportId)"
        method = .delete
        return self
    }
    
    private func processingPostTimeReportSchema(studyTime: String, studyDate: Date, memo: String, tags: [String], userId: Int) -> Self {
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
