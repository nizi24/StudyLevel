//
//  CommentForm.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation

class CommentFormViewModel: ObservableObject {
    @Published var content = ""
    @Published var aleat = false
    @Published var aleatType: AleatType?
    @Published var errorMessage = ""
    
    func createComment(timeReportId: Int) {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let request = CommentRequest().create(userId: id, timeReportId: timeReportId, content: content)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch(result) {
            case .success(_):
                DispatchQueue.main.async {
                    self?.aleatType = .createSuccess
                    self?.aleat = true
                    self?.content = ""
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.errorMessage = "通信に失敗しました。"
                    self?.aleatType = .error
                    self?.aleat = true
                }
            }
        }
    }
    
    enum AleatType {
        case error
        case createSuccess
    }
}
