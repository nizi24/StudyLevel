//
//  WeeklyTargetRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation

class WeeklyTargetRequest: Request {
    var path: String = "/v2/users/:user_id/weekly_targets"
    var method: HTTPMethod = .get
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = WeeklyTarget
    
    func show(userId: Int) -> Self {
        path = "/v2/users/\(userId)/weekly_target"
        return self
    }
    
    func create(userId: Int, targetHour: Int, targetMinute: Int) -> Self {
        path = "/v2/users/\(userId)/weekly_targets"
        method = .post
        do {
            body = try JSONEncoder().encode(["target_time": processingTargetTime(targetHour: targetHour, targetMinute: targetMinute)])
        } catch {
            fatalError()
        }
        return self
    }
    
    func prevWeeklyTarget(userId: Int) -> Self {
        path = "/v2/users/\(userId)/prev_weekly_target"
        return self
    }
    
    private func processingTargetTime(targetHour: Int, targetMinute: Int) -> String {
        let day = targetHour / 24
        let hour = targetHour % 24
        let targetTime = "2000-01-0\(day + 1) \(hour):\(targetMinute)"
        return targetTime
    }
}
