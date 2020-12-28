//
//  SearchTimeReportWithTagViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import Foundation

class SearchTimeReportWithTagViewModel: ObservableObject {
    @Published var timeReports: [TimeReport]?
    
    func searchTimeReportWithTagName(userId: Int, tagName: String) {
        let request = TimeReportsRequest().search(userId: userId, tagName: tagName)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
                }
            case .failure(_): break
            }
        }
    }
    
    func searchTimeReportWithTagNameGetMore(userId: Int, tagName: String) {
        let request = TimeReportsRequest().search(userId: userId, tagName: tagName, offset: timeReports?.count ?? 0)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports?.append(contentsOf: timeReports)
                }
            case .failure(_): break
            }
        }

    }
}
