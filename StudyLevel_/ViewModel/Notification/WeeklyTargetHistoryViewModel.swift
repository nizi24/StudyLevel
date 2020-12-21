//
//  WeeklyTargetHistoryViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import Foundation

class WeeklyTargetHistoryViewModel: ObservableObject {
    @Published var weeklyTargets: [WeeklyTarget] = []
    
    func getWeeklyTargets() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = WeeklyTargetsRequest().index(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let weeklyTargets):
                DispatchQueue.main.async {
                    self?.weeklyTargets = weeklyTargets
                }
            case .failure(_): break
            }
        }
    }
}
