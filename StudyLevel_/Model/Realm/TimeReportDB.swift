//
//  TimeReportDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class TimeReportDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var studyTime: String = ""
    @objc dynamic var studyDate: String = ""
    @objc dynamic var memo: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var likeCount: Int = 0
    @objc dynamic var commentCount: Int = 0
    @objc dynamic var experienceReport: ExperienceRecordDB? = ExperienceRecordDB()
    let creator = LinkingObjects(fromType: UserDB.self, property: "timeReports")
    var tags = List<TagDB>()
    
    override static func primaryKey() -> String? {
            return "id"
    }
        
    func find(id: Int) -> Self? {
        let realm = try! Realm()
        let timeReport = realm.objects(Self.self).filter("id == %@", id).first
        return timeReport
    }
    
    func delete(timeReportId: Int) {
        let realm = try! Realm()
        let deleteTarget = realm.objects(TimeReportDB.self).filter("id == %@", timeReportId)
        if let deleteTargetTags = deleteTarget.first?.tags {
            try! realm.write {
                realm.delete(deleteTargetTags)
            }
        }
        if let deleteTargetExperienceRecord = deleteTarget.first?.experienceReport {
            try! realm.write {
                realm.delete(deleteTargetExperienceRecord)
            }
        }
        try! realm.write {
            realm.delete(deleteTarget)
        }
    }
}
