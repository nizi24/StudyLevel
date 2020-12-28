//
//  UserLevelColor.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import Foundation

class UserLevelColor {
    
    func levelColor(user: SearchUser) -> String {
        if user.experience.level >= 100 {
            return "FF6F00"
        } else if user.experience.level >= 80 {
            return "FF8F00"
        } else if user.experience.level >= 50 {
            return "FFA000"
        } else if user.experience.level >= 20 {
            return "FFCA28"
        } else {
            return "FFD54F"
        }
    }
}
