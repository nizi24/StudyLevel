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
    let creator = LinkingObjects(fromType: UserDB.self, property: "timeReports")
    var tags = List<TagDB>()
    
    override static func primaryKey() -> String? {
            return "id"
    }
    
    func create(viewModel: TimeReportViewModel) -> Self {
        id = viewModel.timeReport.id
        userId = viewModel.timeReport.userId
        studyTime = viewModel.timeReport.studyTime
        studyDate = viewModel.timeReport.studyDate
        memo = viewModel.timeReport.memo
        createdAt = viewModel.timeReport.createdAt
        likeCount = viewModel.likeCount!
        commentCount = viewModel.commentCount!
        for tag in viewModel.tags! {
            tags.append(TagDB().create(tag: tag))
        }
        return self
    }
    
    func find(id: Int) -> Self? {
        let realm = try! Realm()
        let timeReport = realm.objects(Self.self).filter("id == %@", id).first
        return timeReport
    }
    
    func delete(timeReportId: Int) {
        let realm = try! Realm()
        let deleteTarget = realm.objects(TimeReportDB.self).filter("id == %@", timeReportId)
        try! realm.write {
            realm.delete(deleteTarget)
        }
    }
}
