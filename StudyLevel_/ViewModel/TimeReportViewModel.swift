//
//  TimeReportViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class TimeReportViewModel: ObservableObject {
    @Published var timeReport: TimeReport
    @Published var creator: User?
    @Published var avatarURL: URL?
    @Published var experienceRecord: ExperienceRecord?
    @Published var tags: [Tag]?
    @Published var likeCount: Int?
    @Published var commentCount: Int?
    
    
    init(timeReport: TimeReport) {
        self.timeReport = timeReport
        getCreator()
        initGetterOtherThanCreator()
    }
    
    init(timeReport: TimeReport, creator: User?) {
        self.timeReport = timeReport
        if let creator = creator {
            self.creator = creator
        } else {
            getCreator()
        }
        initGetterOtherThanCreator()
    }
    
    func initGetterOtherThanCreator() {
        getTags()
        getExperienceRecord()
        getLikeCount()
        getCommentCount()
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
    
    private func getCreator() {
        let request = UserRequest().show(id: timeReport.userId)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.creator = user
                }
            case .failure(_): break
            }
        }
    }
    
    private func getAvatarURL() {
        let request = AvatarRequest().avatarURL(userId: timeReport.userId)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let avatarURL):
                DispatchQueue.main.async {
                    self.avatarURL = avatarURL
                }
            case .failure(_): break
            }
        }
    }
    
    private func getTags() {
        let request = TagsRequest().index(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let tags):
                DispatchQueue.main.async {
                    self.tags = tags
                }
            case .failure(_): break
            }
        }
    }
    
    private func getExperienceRecord() {
        let request = ExperienceRecordRequest().show(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let experienceRecord):
                DispatchQueue.main.async {
                    self.experienceRecord = experienceRecord
                }
            case .failure(_): break
            }
        }
    }
    
    private func getLikeCount() {
        let request = LikeCountAndCommentCountRequest().likeCount(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let likeCount):
                DispatchQueue.main.async {
                    self.likeCount = likeCount
                }
            case .failure(_): break
            }
        }
    }
    
    private func getCommentCount() {
        let request = LikeCountAndCommentCountRequest().commentCount(timeReportId: timeReport.id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let commentCount):
                DispatchQueue.main.async {
                    self.commentCount = commentCount
                }
            case .failure(_): break
            }
        }

    }
}
