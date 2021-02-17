//
//  CommentViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

class CommentViewModel: ObservableObject {
    @Published var aleat = false
    @Published var aleatType: AleatType? = nil
    @Published var errorMessage = ""
    
    func proccessingLocalHostAvatarURL(comment: Comment) -> String? {
        return comment.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
    }
    
    func displayDeleteButton(creatorId: Int) -> Bool {
        guard let id = CurrentUser().currentUser()?.id else {
            return false
        }
        if creatorId == id {
            return true
        }
        return false
    }
    
    func deleteConfirm() {
        aleatType = .confirmDelete
        aleat = true
    }
    
    func delete(commentId: Int) {
        CurrentUser().getIdToken { idToken in
            let request = CommentRequest().destroy(commentId: commentId, idToken: idToken)
            StudyLevelClient().send(request: request) { [weak self] result in
                switch (result) {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.aleatType = .deleteSuccess
                        self?.aleat = true
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.aleatType = .error
                        self?.errorMessage = "通信エラーが発生しました。"
                        self?.aleat = true
                    }
                }
            }
        }
    }
    
    enum AleatType {
        case error
        case deleteSuccess
        case confirmDelete
    }
}
