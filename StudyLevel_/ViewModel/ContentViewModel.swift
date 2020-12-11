//
//  ContentViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var error = false
    @Published var errorMessage = ""
    @Published var id = 0
    
    init() {
        currentUserSet()
    }
    
    private func currentUserSet() {
        let result = CurrentUser().set()
        switch result {
        case .success(let user):
            id = user.id
            likesSetToRealm()
        case .failure(StudyLevelClientError.communicationFailed):
            error = true
            errorMessage = "通信に失敗しました。"
        case .failure(_):
            error = true
            errorMessage = "エラーが発生しました。"
        }
    }
    
    private func likesSetToRealm() {
        let request = LikesRequest().index(userId: id)
        StudyLevelClient().send(request: request) { result in
            switch (result) {
            case .success(let likes):
                LikeDB().deleteAll()
                for like in likes {
                    LikeDB().createAndSave(like: like)
                }
            case .failure(_): break
            }
        }
    }
}
