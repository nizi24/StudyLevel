//
//  LikeButtonViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import Foundation

class LikeButtonViewModel: ObservableObject {
    @Published var i = 0
    
    func like(timeReport: TimeReport) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = LikeRequest().create(likeableType: "TimeReport", likeableId: timeReport.id, userId: userId, idToken: idToken)
            StudyLevelClient().send(request: request) { result in
                switch (result) {
                case .success(let like):
                    LikeDB().createAndSave(like: like)
                    DispatchQueue.main.async {
                        self.i = 10
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func unlike(timeReport: TimeReport) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = LikeRequest().delete(likeableType: "TimeReport", likeableId: timeReport.id, userId: userId, idToken: idToken)
            StudyLevelClient().send(request: request) { result in
                switch (result) {
                case .success(let like):
                    LikeDB().delete(likeableType: "TimeReport", likeableId: like.likeableId)
                    DispatchQueue.main.async {
                        self.i = -10
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func like(comment: Comment) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = LikeRequest().create(likeableType: "Comment", likeableId: comment.id, userId: userId, idToken: idToken)
            StudyLevelClient().send(request: request) { result in
                switch (result) {
                case .success(let like):
                    LikeDB().createAndSave(like: like)
                    DispatchQueue.main.async {
                        self.i = 10
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func unlike(comment: Comment) {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        CurrentUser().getIdToken { idToken in
            let request = LikeRequest().delete(likeableType: "Comment", likeableId: comment.id, userId: userId, idToken: idToken)
            StudyLevelClient().send(request: request) { result in
                switch (result) {
                case .success(let like):
                    LikeDB().delete(likeableType: "Comment", likeableId: like.likeableId)
                    DispatchQueue.main.async {
                        self.i = -10
                    }
                case .failure(_): break
                }
            }
        }
    }
    
    func liked(timeReport: TimeReport) -> Bool {
        return LikeDB().find(timeReport: timeReport)
    }
    
    func liked(comment: Comment) -> Bool {
        return LikeDB().find(comment: comment)
    }
}
