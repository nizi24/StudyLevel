//
//  SearchTImeReportViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class SearchTImeReportViewModel: ObservableObject, TimeReportsViewModelProtocol {
    @Published var timeReports: [TimeReport]?
    @Published var connecting = false
    @Published var error = false
    @Published var errorMessage = ""
    var message = ""
    var subMessage = ""
    @Published var tagName = ""
    
    func getTimeReports() {
        let request = TimeReportsRequest().search(tagName: tagName)
        
    }
    
    func getTimeReportMore() {
        let request = TimeReportsRequest().search(tagName: tagName, offset: timeReports?.count ?? 0)
        
    }
}
