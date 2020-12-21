//
//  EmphasizeTimeViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation

class EmphasizeTimeViewModel {
    
    func processingHour(dateTimeString: String) -> String {
        let targetTimeDateArray = conversionDateTimeToArray(dateTime: dateTimeString)
        let targetTimeHour = (Int(targetTimeDateArray[0])! - 1) * 24 + Int(targetTimeDateArray[1])!
        return "\(targetTimeHour)"
    }
    
    func processingMinute(dateTimeString: String) -> String {
        let targetTimeDateArray = conversionDateTimeToArray(dateTime: dateTimeString)
        return targetTimeDateArray[2]
    }
        
    private func conversionDateTimeToArray(dateTime: String) -> [String] {
        let splitToArray = dateTime.split(separator: "T")
        let day = splitToArray[0].split(separator: "-")[2]
        let time = splitToArray[1].split(separator: ":")
        let hour = time[0]
        let minutes = time[1]
        return [String(day), String(hour), String(minutes)]
    }

    func timeColor(dateTimeString: String) -> String {
        let time = Int(processingHour(dateTimeString: dateTimeString))! * 60 + Int(processingMinute(dateTimeString: dateTimeString))!
        if time >= 600 {
            return "FF6F00"
        } else if time >= 420 {
            return "FF8F00"
        } else if time >= 300 {
            return "FFA000"
        } else if time >= 150 {
            return "FFCA28"
        } else {
            return "FFD54F"
        }
    }
}
