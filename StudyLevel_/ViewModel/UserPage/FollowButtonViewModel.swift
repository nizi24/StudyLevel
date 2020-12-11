//
//  FollowButtonViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class FollowButtonViewModel: ObservableObject {
    @Published var i = 0
    
    func follow(targetUserId: Int) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        let request = FollowRequest().follow(userId: targetUserId, currentUserId: userId)
        StudyLevelClient().send(request: request) { result in
            switch (result) {
            case .success(_):
                DispatchQueue.main.async {
                    self.i = 10
                }
            case .failure(_): break
            }
        }
    }
    
    func unfollow(targetUserId: Int) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        let request = FollowRequest().unfollow(userId: targetUserId, currentUserId: userId)
        StudyLevelClient().send(request: request) { result in
            switch (result) {
            case .success(_):
                DispatchQueue.main.async {
                    self.i = -10
                }
            case .failure(_): break
            }
        }
    }
}
