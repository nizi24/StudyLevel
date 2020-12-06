//
//  TimeReportDetailViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

class TimeReportDetailViewModel: ObservableObject {
    @Published var connecting = false
    @Published var timeReport: TimeReport
    @Published var error = false
    @Published var errorMessage = ""
    @Published var comments: [Comment] = []
    
    init(timeReport: TimeReport, likesCount: Int) {
        self.timeReport = timeReport
        self.timeReport.likesCount = likesCount
        getComments()
    }
    
    func reload() {
        connecting = true
        getComments()
        let request = TimeReportRequest().show(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch(result) {
            case .success(let timeReport):
                DispatchQueue.main.async {
                    self?.timeReport = timeReport
                    self?.timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
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
    
    private func getComments() {
        let request = CommentsRequest().index(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch(result) {
            case .success(let comments):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.comments = comments
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
