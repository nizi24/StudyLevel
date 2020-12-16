//
//  FollowingViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import Foundation

class FollowingViewModel: ObservableObject  {
    @Published var followingUser: [SearchUser]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    
    func getFollowingUser(userId: Int) {
        connecting = true
        let request = SearchUserRequest().following(userId: userId)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let following):
                DispatchQueue.main.async {
                    self?.followingUser = following
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.errorMessage = "通信に失敗しました。"
                    self?.error = true
                }
            }
        }
    }
}
