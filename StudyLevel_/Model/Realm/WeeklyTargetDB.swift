//
//  WeeklyTargetDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class WeeklyTargetDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var startDate: String = ""
    @objc dynamic var endDate: String = ""
    @objc dynamic var achieve: Bool = false
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var checked: Bool = false
    @objc dynamic var targetTime: String = ""
    @objc dynamic var progress: String = ""
    
    override static func primaryKey() -> String? {
            return "id"
    }

    func create(weeklyTarget: WeeklyTarget?) -> Self? {
        guard let weeklyTarget = weeklyTarget else {
            return nil
        }
        self.id = weeklyTarget.id
        self.userId = weeklyTarget.userId
        self.startDate = weeklyTarget.startDate
        self.endDate = weeklyTarget.endDate
        self.achieve = weeklyTarget.achieve
        self.createdAt = weeklyTarget.createdAt
        self.updatedAt = weeklyTarget.updatedAt
        self.checked = weeklyTarget.checked
        self.targetTime = weeklyTarget.targetTime
        self.progress = weeklyTarget.progress
        return self
    }
}
