//
//  TimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

struct TimeReport: Decodable, Hashable {
    var id: Int
    var userId: Int
    var studyTime: String
    var studyDate: String
    var memo: String
    var createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case studyTime = "study_time"
        case studyDate = "study_date"
        case memo
        case createdAt = "created_at"
    }
    
    init(timeReportDB: TimeReportDB) {
        id = timeReportDB.id
        userId = timeReportDB.userId
        studyTime = timeReportDB.studyTime
        studyDate = timeReportDB.studyDate
        memo = timeReportDB.memo
        createdAt = timeReportDB.createdAt
    }
}
