//
//  ContentViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation
import FirebaseAuth

class ContentViewModel: ObservableObject {
    @Published var error = false
    @Published var errorMessage = ""
    @Published var id = 0
    
    init() {
        currentUserSet()
    }
    
    private func currentUserSet() {
        let result = CurrentUser().set()
        switch result {
        case .success(let user):
            id = user.id
        case .failure(StudyLevelClientError.communicationFailed):
            error = true
            errorMessage = "通信に失敗しました。"
        case .failure(_):
            error = true
            errorMessage = "エラーが発生しました。"
        }
    }
}
