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
    @Published var studyMinute = 0
    @Published var memo = ""
    
    
    func oneWeekBefore() -> Date {
        let oneWeekBefore = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
        return Calendar.current.startOfDay(for: oneWeekBefore)
    }
    
    func processingStudyDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ja_JP")
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Tokyo")
        dateFormatter.dateFormat = "yyyy年MM月dd日 HH時mm分"
        return dateFormatter.string(from: studyDate)
    }
}
