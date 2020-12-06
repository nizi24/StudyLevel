//
//  CreateTimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/23.
//

import Foundation
import UIKit

class TimeReportFormViewModel: ObservableObject {
    @Published var studyDate = Date()
    @Published var studyHour = 0
    @Published var studyMinute = 0
    @Published var tagName = ""
    @Published var tags: [String] = []
    @Published var errorMessage = ""
    @Published var memo = ""
    var timeReportId: Int?
    
    init() {}
    
    init(timeReport: TimeReport) {
        timeReportId = timeReport.id
        studyDate = dateFromString(string: timeReport.studyDate, format: "yyyy-MM-dd'T'HH:mm:ss.SSSXXX")
        let studyTime = timeReport.studyTime.split(separator: "T")[1]
        studyHour = Int(studyTime.split(separator: ":")[0])!
        studyMinute = Int(studyTime.split(separator: ":")[1])!
        tags = timeReport.tags.map { $0.name }
        memo = timeReport.memo
    }
    
    func dateFromString(string: String, format: String) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        return formatter.date(from: string)!
    }
    
    func addTag() {
        switch TimeReportValidation().isTagValid(tagName: tagName, tags: tags) {
        case .failure(.tagIsEmpty):
            errorMessage = "タグは１文字以上でないと作成できません。"
        case .failure(.tagIsTooLong):
            errorMessage = "タグは50文字以内である必要があります。"
        case .failure(.tagsTooMany):
            errorMessage = "タグは一つの記録に10個までつけることができます。"
        case .failure(.tagsAreUnique):
            errorMessage = "同じタグをつけることはできません。"
        case .success(_):
            tags.append(tagName)
            tagName = ""
            errorMessage = ""
        default: break
        }
    }
    
    func removeTag(tagName: String) {
        tags = tags.filter { $0 != tagName }
    }
    
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
