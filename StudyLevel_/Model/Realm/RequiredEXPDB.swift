//
//  RequiredEXP.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class RequiredEXPDB: Object {
    @objc dynamic var level: Int = 0
    @objc dynamic var totalExperience: Int = 0
    @objc dynamic var requiredEXP: Int = 0
    
    override static func primaryKey() -> String? {
            return "level"
    }
    
    func create(requiredEXP: RequiredEXP) -> Self {
        self.level = requiredEXP.level
        self.totalExperience = requiredEXP.totalExperience
        self.requiredEXP = requiredEXP.requiredEXP
        return self
    }
}
