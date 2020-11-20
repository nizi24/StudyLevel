//
//  GetUser.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

class GetUser {
    var user: User?
    
    func getUser(id: Int) -> User? {
        let request = UserRequest().show(id: id)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.user
    }
}
