//
//  CreateTimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/23.
//

import Foundation

class CreateTimeReportViewModel: ObservableObject {
    @Published var studyDate = Date()
    @Published var studyHour = 0
    @Published var tapStudyTime = false
    
    
    func oneWeekBefore() -> Date {
        let oneWeekBefore = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return Calendar.current.startOfDay(for: oneWeekBefore)
    }
}
