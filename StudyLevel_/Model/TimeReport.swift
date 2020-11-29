//
//  TimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

struct TimeReport: Decodable {    
    var id: Int
    var userId: Int
    var studyTime: String
    var studyDate: String
    var memo: String
    var createdAt: String
    var tags: [Tag]
    var experienceRecord: ExperienceRecord
    var creator: User
    var likesCount: Int
    var commentsCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case studyTime = "study_time"
        case studyDate = "study_date"
        case memo
        case createdAt = "created_at"
        case tags
        case experienceRecord = "experience_record"
        case creator = "user"
        case likesCount = "likes_count"
        case commentsCount = "comments_count"
    }
    
//    init(timeReportDB: TimeReportDB) {
//        id = timeReportDB.id
//        userId = timeReportDB.userId
//        studyTime = timeReportDB.studyTime
//        studyDate = timeReportDB.studyDate
//        memo = timeReportDB.memo
//        createdAt = timeReportDB.createdAt
//        tags = []
//        tags.append(contentsOf: Array(_immutableCocoaArray: timeReportDB.tags))
//        experienceRecord = ExperienceRecord(experienceRecordDB: timeReportDB.experienceReport!)
//    }
}
