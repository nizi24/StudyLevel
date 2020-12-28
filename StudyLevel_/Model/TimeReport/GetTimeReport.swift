//
//  GetTimeReport.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

class GetTimeReport {
    var timeReports: [TimeReport]?
    var likeCount: Int?
    var commentCount: Int?
    
    func getUserTimeReports(userId: Int) -> [TimeReport]? {
        let request = TimeReportsRequest().index(userId: userId)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let timeReports):
                self.timeReports = timeReports
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.timeReports
    }
    
    func getLikeCount(timeReportId: Int) -> Int? {
        let request = LikeCountAndCommentCountRequest().likeCount(timeReportId: timeReportId)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let likeCount):
                self.likeCount = likeCount
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.likeCount
    }
    
    func getCommentCount(timeReportId: Int) -> Int? {
        let request = LikeCountAndCommentCountRequest().commentCount(timeReportId: timeReportId)
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let commentCount):
                self.commentCount = commentCount
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return self.commentCount
    }

}
