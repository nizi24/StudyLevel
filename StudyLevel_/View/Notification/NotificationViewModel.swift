//
//  NotificationViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

class NotificationViewModel {
    
    func processingCreatedAt(createdAt: String) -> String {
        let dateArray = createdAt.split(separator: "T")[0].split(separator: "-")
        let date = "\(dateArray[0])年\(dateArray[1])月\(dateArray[2])日"
        let timeArray = processingTimeArray(date: createdAt)
        let time = "\(timeArray[0]):\(timeArray[1])"
        return date + " " + time
    }
    
    private func processingTimeArray(date: String) -> [Substring] {
        return date.split(separator: "T")[1].split(separator: ":")
    }

}
