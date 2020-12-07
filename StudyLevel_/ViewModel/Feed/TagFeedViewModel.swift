//
//  TagFeedViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/07.
//

import Foundation

class TagFeedViewModel: ObservableObject, TimeReportsViewModelProtocol {
    @Published var timeReports: [TimeReport]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    @Published var tagFollowingCount: Int?
    @Published var message = ""
    @Published var subMessage = ""
    
    init() {
        getFollowingCount()
    }
    
    private func getFollowingCount() {
        guard let id = CurrentUser().currentUser()?.id else {
            error = true
            errorMessage = "認証に失敗しました"
            return
        }
        let request = FollowCountRequest().tagFollowingCount(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let followingCount):
                DispatchQueue.main.async {
                    self?.tagFollowingCount = followingCount
                    if followingCount == 0 {
                        self?.message = "まだタグをフォローしていません。"
                        self?.subMessage = "タグフィードにはフォローしているタグがついている全てのユーザーの投稿が表示されます。"
                    }
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
    
    func getTimeReports() {
        guard let id = CurrentUser().currentUser()?.id else {
            error = true
            errorMessage = "認証に失敗しました"
            return
        }
        connecting = true
        let request = TimeReportsRequest().tagFeed(userId: id, limit: timeReports?.count ?? 30)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
                    if self?.message.isEmpty ?? false && timeReports.isEmpty {
                        self?.message = "まだ投稿がありません。"
                    }
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
    
    func getTimeReportMore() {
        guard let id = CurrentUser().currentUser()?.id else {
            error = true
            errorMessage = "認証に失敗しました"
            return
        }
        connecting = true
        let request = TimeReportsRequest().tagFeed(userId: id, offset: timeReports?.count ?? 0)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports?.append(contentsOf: timeReports)
                    self?.connecting = false
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
}
