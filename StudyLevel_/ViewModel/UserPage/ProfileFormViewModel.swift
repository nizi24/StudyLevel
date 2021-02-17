//
//  ProfileFormViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class ProfileFormViewModel: ObservableObject {
    @Published var name: String
    @Published var screenName: String
    @Published var profile: String
    @Published var validationErrorMessages: [String] = []
    @Published var connecting = false
    @Published var alert = false
    @Published var alertType: AlertType = .error
    @Published var errorMessage = ""
    
    init(name: String?, screenName: String?, profile: String?) {
        self.name = name ?? ""
        self.screenName = screenName ?? ""
        self.profile = profile ?? ""
    }
    
    func update() {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            return
        }
        guard validation() else {
            return
        }
        connecting = true
        CurrentUser().getIdToken { idToken in
            let request = UserRequest().update(userId: currentUserId, name: self.name, screenName: self.screenName, profile: self.profile, idToken: idToken)
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
                        self?.alertType = .error
                        self?.errorMessage = "通信に失敗しました。"
                        self?.alert = true
                    }
                }
            }
        }
    }
    
    private func validation() -> Bool {
        validationErrorMessages = []
        let validationResults = ProfileFormValidation().isValid(name: name, screenName: screenName, profile: profile)
        for result in validationResults {
            switch result {
            case .none: break
            case .nameIsTooLong:
                validationErrorMessages.append("名前は20文字以内である必要があります。")
            case .some(.nameIsRequired):
                validationErrorMessages.append("名前は必須項目です。")
            case .some(.screenNameIsNotValid):
                validationErrorMessages.append("ユーザーIDは半角英数字とアンダーバーのみが使用できます。")
            case .some(.screenNameIsTooLong):
                validationErrorMessages.append("ユーザーIDは15文字以内である必要があります。")
            case .some(.screenNameIsTooShort):
                validationErrorMessages.append("ユーザーIDは5文字以上である必要があります。")
            case .some(.screenNameIsRequired):
                validationErrorMessages.append("ユーザーIDは必須項目です。")
            case .some(.screenNameIsUsed):
                validationErrorMessages.append("ユーザーIDは既に他のユーザーに使用されています。")
            case .some(.profileIsTooLong):
                validationErrorMessages.append("プロフィールは160文字以内である必要があります。")
            }
        }
        return validationErrorMessages.isEmpty
    }
    
    enum AlertType {
        case success
        case error
    }
}
