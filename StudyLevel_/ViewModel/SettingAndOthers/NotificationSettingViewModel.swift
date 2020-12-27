//
//  NotificationSettingViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation

class NotificationSettingViewModel: ObservableObject {
    @Published var commentNotice = true
    @Published var commentLikeNotice = true
    @Published var timeReportLikeNotice = true
    @Published var followNotice = true
    @Published var connecting = false
    @Published var alert = false
    @Published var alertType: AlertType = .error
    @Published var errorMessage = ""
    
    func getSetting() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        connecting = true
        let request = SettingRequest().edit(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let setting):
                DispatchQueue.main.async {
                    self?.commentNotice = setting.commentNotice
                    self?.commentLikeNotice = setting.commentLikeNotice
                    self?.timeReportLikeNotice = setting.timeReportLikeNotice
                    self?.followNotice = setting.followNotice
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.errorMessage = "通信に失敗しました。"
                    self?.alertType = .error
                    self?.alert = true
                }
            }
        }
    }
    
    func updateSetting() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        connecting = true
        let request = SettingRequest().update(userId: id, commentNotice: commentNotice, commentLikeNotice: commentLikeNotice,
                                              timeReportLikeNotice: timeReportLikeNotice, followNotice: followNotice)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.alertType = .updateSuccess
                    self?.alert = true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.errorMessage = "通信に失敗しました。"
                    self?.alertType = .error
                    self?.alert = true
                }
            }
        }
    }
    
    enum AlertType {
        case updateSuccess
        case error
    }
}
