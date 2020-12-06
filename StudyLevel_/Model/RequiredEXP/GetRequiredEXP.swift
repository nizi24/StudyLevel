//
//  GetRequiredEXP.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import Foundation

class GetRequiredEXP {
    var requiredEXP: RequiredEXP?
    
    func getRequiredEXP(level: Int) -> RequiredEXP? {
        let request = RequiredEXPRequest().show(level: level)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let requiredEXP):
                self.requiredEXP = requiredEXP
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.requiredEXP
    }
}
