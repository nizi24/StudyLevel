//
//  WeeklyTargetFormViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class WeeklyTargetFormViewModel: ObservableObject {
    @Published var targetHour = 0
    @Published var targetMinute = 0
    @Published var connecting = false
    @Published var aleat = false
    @Published var aleatType: AleatType = .error
    @Published var errorMessage = ""
    @Published var validationMessage = ""
    
    func create() {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            aleatType = .error
            errorMessage = "認証に失敗しました。"
            aleat = true
            return
        }
        switch WeeklyTargetValidation().targetTime(targetHour: targetHour, targetMinute: targetMinute) {
        case .invalidTime:
            validationMessage = "目標は１分以上でないと作成できません。"
            return
        default: break
        }
        connecting = true
        let request = WeeklyTargetRequest().create(userId: currentUserId, targetHour: targetHour, targetMinute: targetMinute)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(_):
                DispatchQueue.main.async {
                    self?.aleatType = .success
                    self?.aleat = true
                    self?.targetHour = 0
                    self?.targetMinute = 0
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.aleatType = .error
                    self?.errorMessage = "通信に失敗しました。"
                    self?.aleat = true
                }
            }
        }
    }
    
    struct WeeklyTargetValidation {
        
        func targetTime(targetHour: Int, targetMinute: Int) -> ValidationError? {
            if targetHour == 0 && targetMinute == 0 {
                return .invalidTime
            }
            return nil
        }
        
        enum ValidationError: Error {
            case invalidTime
        }
    }
    
    enum AleatType {
        case success
        case error
    }
}
