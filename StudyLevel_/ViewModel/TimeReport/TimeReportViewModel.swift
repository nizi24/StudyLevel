//
//  TimeReportViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation
import SwiftUI

class TimeReportViewModel: ObservableObject {
    @Published var timeReport: TimeReport
    @Published var errorMessage = ""
    @Published var aleat = false
    @Published var aleatType: AleatType? = nil
    
    init(timeReport: TimeReport) {
        self.timeReport = timeReport
        self.timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
    }
    
    func confirmDelete() {
        aleatType = .confirmDelete
        aleat = true
    }
    
    func delete() {
        let request = TimeReportRequest().delete(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.aleatType = .deleteSuccess
                    self.aleat = true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.aleatType = .error
                    self.errorMessage = "通信に失敗しました。"
                    self.aleat = true
                }
            }
        }
    }
    
    func processingStudyDate() -> String {
        let studyDate = timeReport.studyDate
        let dateArray = studyDate.split(separator: "T")[0].split(separator: "-")
        let date = "\(dateArray[0])年\(dateArray[1])月\(dateArray[2])日"
        let timeArray = processingTimeArray(date: studyDate)
        let time = "\(timeArray[0]):\(timeArray[1])"
        return date + " " + time
    }
    
    func processingStudyHour() -> String {
        let studyTime = timeReport.studyTime
        var hour: String = String(processingTimeArray(date: studyTime)[0])
        if hour.first == "0" {
            let start = hour.index(hour.startIndex, offsetBy: 1)
            let end = hour.index(start, offsetBy: 1)
            hour = String(hour[start..<end])
        }
        return hour
    }
    
    func processingStudyMinute() -> String {
        let studyTime = timeReport.studyTime
        return String(processingTimeArray(date: studyTime)[1])
    }
    
    func changeColor() -> String {
        let time = Int(processingStudyHour())! * 60 + Int(processingStudyMinute())!
        if time >= 180 {
            return "FF6F00"
        } else if time >= 120 {
            return "FF8F00"
        } else if time >= 60 {
            return "FFA000"
        } else if time >= 30 {
            return "FFCA28"
        } else {
            return "FFD54F"
        }
    }
    
    private func processingTimeArray(date: String) -> [Substring] {
        return date.split(separator: "T")[1].split(separator: ":")
    }
    
    enum AleatType: String {
        case deleteSuccess
        case error
        case confirmDelete
    }

}
