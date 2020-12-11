//
//  RequiredEXP.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

struct RequiredEXP: Decodable {
    var level: Int
    var totalExperience: Int
    var requiredEXP: Int
    
    enum CodingKeys: String, CodingKey {
        case level
        case totalExperience = "total_experience"
        case requiredEXP = "required_exp"
    }
}
