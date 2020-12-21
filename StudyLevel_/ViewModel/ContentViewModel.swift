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
    @Published var notices: [Notice] = []
    @Published var prevWeeklyTarget: WeeklyTarget?
    @Published var prevWeeklyTargetCheck = true
    
    init() {
        currentUserSet()
    }
    
    @objc func getNotices() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = NoticesRequest().index(userId: id, limit: notices.count == 0 ? 30 : notices.count)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let notices):
                DispatchQueue.main.async {
                    self?.notices = notices
                }
            case .failure(_): break
            }
        }
    }
    
    func getNoticesMore() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = NoticesRequest().index(userId: id, offset: notices.count)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let notices):
                DispatchQueue.main.async {
                    self?.notices.append(contentsOf: notices)
                }
            case .failure(_): break
            }
        }
    }
    
    func noticesIncludeNonChecked() -> Bool {
        for notice in notices {
            if !notice.checked { return true }
        }
        return false
    }
    
    func noticesCheck() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = NoticesRequest().check(userId: id, limit: notices.count == 0 ? 30 : notices.count)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let notices):
                DispatchQueue.main.async {
                    self?.notices = notices
                }
            case .failure(_): break
            }
        }
    }
    
    func getPrevWeeklyTarget() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = WeeklyTargetRequest().prevWeeklyTarget(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let weeklyTarget):
                DispatchQueue.main.async {
                    self?.prevWeeklyTarget = weeklyTarget
                    self?.prevWeeklyTargetCheck = false
                }
            case .failure(_): break
            }
        }
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
