//
//  DeviceRegister.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/19.
//

import Foundation

struct DeviceRegister {
    
    func register(token: String?) {
        guard let currentUserId = CurrentUser().currentUser()?.id, let token = token else {
            return
        }
        let request = DeviceRequest().create(userId: currentUserId, token: token)
        StudyLevelClient().send(request: request) { _ in
        }
    }
}
