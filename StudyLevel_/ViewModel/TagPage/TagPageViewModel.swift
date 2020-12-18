//
//  TagPageView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class TagPageViewModel: ObservableObject, TimeReportsViewModelProtocol {
    var tagId: Int
    @Published var tagPage: TagPage = TagPage(id: 0, name: "", createdAt: "", updatedAt: "", followerCount: 0, timeReportCount: 0, following: false)
    @Published var timeReports: [TimeReport]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    @Published var message = ""
    @Published var subMessage = ""

    init(tagId: Int) {
        self.tagId = tagId
    }
    
    func getTagPage() {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        connecting = true
        let request = TagPageRequest().show(tagId: tagId, currentUserId: userId)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let tagPage):
                DispatchQueue.main.async {
                    self?.tagPage = tagPage
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
        let timeReportsCount = timeReports?.count ?? 30
        let request = TimeReportsRequest().index(tagId: tagId, limit: timeReportsCount >= 30 ? timeReportsCount : 30)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
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
    
    func getTimeReportMore() {
        connecting = true
        let request = TimeReportsRequest().index(tagId: tagId, offset: timeReports?.count ?? 0)
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
