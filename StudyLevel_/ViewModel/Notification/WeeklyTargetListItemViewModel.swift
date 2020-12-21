//
//  WeeklyTargetListItemViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

class WeeklyTargetListItemViewModel: ObservableObject {
    var weeklyTarget: WeeklyTarget
    @Published var experienceRecord: WeeklyTargetExperienceRecord?
    
    init(weeklyTarget: WeeklyTarget) {
        self.weeklyTarget = weeklyTarget
    }
    
    func getExperieceRecord() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        guard weeklyTarget.achieve else {
            return
        }
        let request = WeeklyTargetExperienceRecordRequest().show(userId: id, weeklyTargetId: weeklyTarget.id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let experienceRecord):
                DispatchQueue.main.async {
                    self?.experienceRecord = experienceRecord
                }
            case .failure(_): break
            }
        }
    }
    
    func processingWeekly() -> String {
        let pattern = "^(\\d{4})-0?(\\d{1,2})-(\\d{2})"
        let weeklyStartArray = weeklyTarget.startDate.capture(pattern: pattern, group: [1, 2, 3])
        let weeklyEndArray = weeklyTarget.endDate.capture(pattern: pattern, group: [1, 2, 3])
        let weeklyStartStr = "\(weeklyStartArray[0])年\(weeklyStartArray[1])月\(weeklyStartArray[2])日"
        let weeklyEndStr = "\(weeklyEndArray[0])年\(weeklyEndArray[1])月\(weeklyEndArray[2])日"
        return "\(weeklyStartStr)〜\(weeklyEndStr)"
    }
}
