//
//  TimeReportDetailViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

class TimeReportDetailViewModel: ObservableObject {
    @Published var timeReport: TimeReport
    @Published var alert = false
    @Published var errorMessage = ""
    
    init(timeReport: TimeReport) {
        self.timeReport = timeReport
    }
    
    func reload() {
        let request = TimeReportRequest().show(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch(result) {
            case .success(let timeReport):
                DispatchQueue.main.async {
                    self?.timeReport = timeReport
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.alert = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
}
