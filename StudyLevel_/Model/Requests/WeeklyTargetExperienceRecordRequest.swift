//
//  WeeklyTargetExperienceRecordRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

class WeeklyTargetExperienceRecordRequest: Request {
    var path: String = "/v2/users/:user_id/weekly_targets/:weekly_target_id/weekly_target_experince_record"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = WeeklyTargetExperienceRecord
    
    func show(userId: Int, weeklyTargetId: Int) -> Self {
        path = "/v2/users/\(userId)/weekly_targets/\(weeklyTargetId)/weekly_target_experience_record"
        return self
    }
}
