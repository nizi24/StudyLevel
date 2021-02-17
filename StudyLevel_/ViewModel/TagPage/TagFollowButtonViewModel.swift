//
//  TagFollowButtonViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class TagFollowButtonViewModel: ObservableObject, FollowButtonViewModelProtocol {
    @Published var i = 0
    
    func follow(targetId: Int) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = FollowRequest().follow(tagId: targetId, currentUserId: userId, idToken: idToken)
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
    }
    
    func unfollow(targetId: Int) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = FollowRequest().unfollow(tagId: targetId, currentUserId: userId, idToken: idToken)
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
}
