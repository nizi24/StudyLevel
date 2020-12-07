//
//  NewestTimeReportsViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import Foundation

class NewestTimeReportsViewModel: ObservableObject, TimeReportsViewModelProtocol {
    @Published var timeReports: [TimeReport]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    @Published var message = ""
    @Published var subMessage = ""
    
    func getTimeReports() {
        connecting = true
        let request = TimeReportsRequest().index(limit: timeReports?.count ?? 30)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
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
        connecting = true
        let request = TimeReportsRequest().index(offset: timeReports?.count ?? 0)
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
