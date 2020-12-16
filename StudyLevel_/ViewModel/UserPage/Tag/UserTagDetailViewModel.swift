//
//  UserTagDetailViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/14.
//

import Foundation

class UserTagDetailViewModel: ObservableObject {
    var id: Int
    @Published var mainTags: [MainTag]?
    @Published var followingTags: [Tag]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    
    init(id: Int) {
        self.id = id
    }
    
    func getToServer() {
        connecting = true
        getMainTags()
        getFollowingTags()
    }
    
    private func getMainTags() {
        let request = MainTagsRequest().mainTags(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let mainTags):
                DispatchQueue.main.async {
                    self?.mainTags = mainTags
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getFollowingTags() {
        let request = TagsRequest().followingTags(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async {
                    self?.followingTags = tags
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = false
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }

    }
}
