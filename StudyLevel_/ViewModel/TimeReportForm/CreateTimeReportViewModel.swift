//
//  CreateTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/28.
//

import Foundation

class CreateTimeReportViewModel: ObservableObject {
    @Published var error = false
    @Published var errorMessage: String? = nil
    @Published var success = false
    @Published var connecting = false
    
    func create(timeReportFormViewModel: TimeReportFormViewModel) {
        guard timeReportFormViewModel.studyHour != 0 || timeReportFormViewModel.studyMinute != 0 else {
            errorMessage = "学習時間は１分以上でないと記録できません。"
            error = true
            return
        }
        connecting = true
        guard let id = CurrentUser().currentUser()?.id else {
            errorMessage = "認証に失敗しました。"
            error = true
            return
        }
        let request = TimeReportRequest().create(
            studyTime: processStudyTime(studyHour: timeReportFormViewModel.studyHour, studyMinute: timeReportFormViewModel.studyMinute),
            studyDate: timeReportFormViewModel.studyDate, memo: timeReportFormViewModel.memo,
            tags: timeReportFormViewModel.tags, userId: id)
        StudyLevelClient().send(request: request, completion: { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.connecting = false
                    self.success = true
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.errorMessage = "通信に失敗しました。"
                    self.error = true
                    self.connecting = false
                }
            }
        })
    }
    
    private func processStudyTime(studyHour hour: Int, studyMinute minute: Int) -> String {
        return "\(hour):\(minute)"
    }
}
