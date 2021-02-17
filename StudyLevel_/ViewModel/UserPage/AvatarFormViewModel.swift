//
//  AvatarFormViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import Foundation
import SwiftUI

class AvatarFormViewModel: ObservableObject {
    @Published var validationError: String?
    @Published var connecting = false
    @Published var alert = false
    @Published var alertType: AlertType = .error
    @Published var errorMessage = ""
    
    func updateAvatar(image: UIImage?) {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            return
        }
        guard validation(image: image) else {
            return
        }
        connecting = true
        CurrentUser().getIdToken { idToken in
            let request = UserRequest().update_avatar(userId: currentUserId, image: image!, idToken: idToken)
            StudyLevelClient().send(request: request) { [weak self] result in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self?.connecting = false
                        self?.alertType = .success
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
    }
    
    private func validation(image: UIImage?) -> Bool {
        validationError = ""
        let result = AvatarImageValidation().isValidImage(image: image)
        switch result {
            case .notSelected:
                validationError = "画像が選択されていません。"
            case .imageSizeIsTooBig:
                validationError = "画像サイズは5MB以下である必要があります。"
            case .none: break
        }
        if let validationError = validationError, validationError.isEmpty {
            return true
        }
        return false
    }
    
    enum AlertType {
        case success
        case error
    }
}
