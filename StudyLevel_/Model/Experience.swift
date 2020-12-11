//
//  Experience.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

struct Experience: Decodable {
    var id: Int
    var userId: Int
    var level: Int
    var totalExperience: Int
    var experienceToNext: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case level
        case totalExperience = "total_experience"
        case experienceToNext = "experience_to_next"
    }
    
    init?(experienceDB: ExperienceDB?) {
        guard let experienceDB = experienceDB else {
            return nil
        }
        id = experienceDB.id
        userId = experienceDB.userId
        level = experienceDB.level
        totalExperience = experienceDB.totalExperience
        experienceToNext = experienceDB.experienceToNext
    }
}