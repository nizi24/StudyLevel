//
//  CreateTimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/23.
//

import Foundation

class CreateTimeReportViewModel: ObservableObject {
    @Published var timeReports: [TimeReportDB] = []
    
    func getTimeReports() {
        guard let user = UserDB().getCurrentUser() else {
            return
        }
        timeReports = []
        timeReports.append(contentsOf: user.timeReports)
    }
}
