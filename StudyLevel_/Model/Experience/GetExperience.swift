//
//  GetExperience.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

class GetExperience {
    var experience: Experience?
    
    func getExperience(userId: Int) -> Experience? {
        let request = ExperienceRequest().show(userId: userId)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let experience):
                self.experience = experience
            case .failure(_):  break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.experience
    }
}
