//
//  FollowersViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import Foundation

class FollowersViewModel: ObservableObject {
    @Published var followers: [SearchUser]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""

    
    func getFollowers(userId: Int) {
        connecting = true
        let request = SearchUserRequest().followers(userId: userId)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let followers):
                DispatchQueue.main.async {
                    self?.followers = followers
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
