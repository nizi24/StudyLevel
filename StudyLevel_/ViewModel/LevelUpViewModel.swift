//
//  LevelUpViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/24.
//

import Foundation

class LevelUpViewModel: ObservableObject {
    @Published var isShowing = false
    @Published var level = 0
    
    func getExperienceToServer() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = ExperienceRequest().show(userId: id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let experience):
                DispatchQueue.main.async {
                    if let beforeLevel = CurrentUser().currentUser()?.level {
                        if beforeLevel < experience.level {
                            self.level = experience.level
                            self.isShowing = true
                            CurrentUser().setExperiences(level: experience.level, exprience: experience.totalExperience,
                                                         toNext: experience.experienceToNext)
                        }
                    }
                }
            case .failure(_): break
            }
        }
    }
}
