//
//  ExperienceRecordDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class ExperienceRecordDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var timeReportId: Int = 0
    @objc dynamic var experiencePoint: Int = 0
    @objc dynamic var bonusMultiplier: Double = 0
    
    override static func primaryKey() -> String? {
            return "id"
    }

}
