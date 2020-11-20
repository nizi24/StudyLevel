//
//  MyPageViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

class MyPageViewModel: ObservableObject {
    @Published var user: User? = nil
    @Published var experience: Experience? = nil
    @Published var requiredEXP: RequiredEXP? = nil
    @Published var errorMessage = ""
    
    init() {
        getUser()
        getExperience()
        getRequiredEXP()
    }
        
    func getUser() {
        guard let id = CurrentUser().currentUser()?.id else {
            errorMessage = "認証に失敗しました"
            return
        }
        user = GetUser().getUser(id: id)
    }
    
    func getExperience() {
        guard let id = CurrentUser().currentUser()?.id else {
            errorMessage = "認証に失敗しました"
            return
        }
        experience = GetExperience().getExperience(userId: id)
    }
    
    func getRequiredEXP() {
        guard let level = experience?.level else {
            errorMessage = "通信に失敗しました"
            return
        }
        requiredEXP = GetRequiredEXP().getRequiredEXP(level: level)
    }
    
    func progress() -> Double? {
        guard let experienceToNext = experience?.experienceToNext, let requiredEXP = requiredEXP?.requiredEXP else {
            return nil
        }
        let proportion: Double = 100 - Double(experienceToNext) / Double(requiredEXP) * 100
        if proportion == 100 {
            return 0
        } else {
            return proportion
        }
    }
    
    func progressNumeretor() -> String {
        guard let experienceToNext = experience?.experienceToNext, let requiredEXP = requiredEXP?.requiredEXP else {
            return ""
        }
        return "\(requiredEXP - experienceToNext)/\(requiredEXP)"
    }
    
    func levelColor() -> String {
        guard let level = experience?.level else {
           return "FFD54F"
        }
        if level >= 100 {
        return "FF6F00"
      } else if level >= 80 {
        return "FF8F00"
      } else if level >= 50 {
        return "FFA000"
      } else if level >= 20 {
        return "FFCA28"
      } else {
        return "FFD54F"
      }
    }
}
