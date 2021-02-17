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
                    self?.currentUserSet()
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
        CurrentUser().getIdToken { idToken in
            let request = NoticesRequest().check(userId: id, limit: self.notices.count == 0 ? 30 : self.notices.count, idToken: idToken)
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
    
    func currentUserSet() {
        let result = CurrentUser().set()
        switch result {
        case .success(let user):
            id = user.id
            likesSetToRealm()
            blockingSetToRealm()
        case .failure(StudyLevelClientError.communicationFailed):
            error = true
            errorMessage = "通信に失敗しました。"
        case .failure(_):
            error = true
            errorMessage = "エラーが発生しました。"
        }
    }
    
    func likesSetToRealm() {
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
    
    func blockingSetToRealm() {
        CurrentUser().getIdToken { idToken in
            let request = BlocksRequest().index(userId: self.id, idToken: idToken)
            StudyLevelClient().send(request: request) { result in
                switch result {
                case .success(let blocks):
                    BlockDB().deleteAll()
                    for block in blocks {
                        BlockDB().create(blockedUserId: block.blockedId)
                    }
                case .failure(_): break
                }
            }
        }
    }
}
