//
//  ExperienceDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class ExperienceDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var userId: Int = 0
    @objc dynamic var level: Int = 0
    @objc dynamic var totalExperience: Int = 0
    @objc dynamic var experienceToNext: Int = 0
    
    override static func primaryKey() -> String? {
            return "id"
    }
    
    func create(experience: Experience) -> Self {
        self.id = experience.id
        self.userId = experience.userId
        self.level = experience.level
        self.totalExperience = experience.totalExperience
        self.experienceToNext = experience.experienceToNext
        return self
    }
}
