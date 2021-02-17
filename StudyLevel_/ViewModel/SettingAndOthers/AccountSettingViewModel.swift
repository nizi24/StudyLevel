//
//  AccountSettingViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import Foundation
import FirebaseAuth

class AccountSettingViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var confirmationPassword = ""
    @Published var connecting = false
    @Published var alert = false
    @Published var alertType: AlertType = .error
    @Published var errorMessage = ""
    @Published var emailValidationErrorMessage = ""
    @Published var passwordValidationErrorMessage = ""
    
    func getEmail() {
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        connecting = true
        CurrentUser().getIdToken { idToken in
            let request = EmailRequest().getEmail(uid: uid, idToken: idToken)
            StudyLevelClient().send(request: request) { [weak self] result in
                switch result {
                case .success(let email):
                    DispatchQueue.main.async {
                        self?.email = email
                        self?.connecting = false
                    }
                case .failure(_):
                    DispatchQueue.main.async {
                        self?.errorMessage = "通信に失敗しました。"
                        self?.alertType = .error
                        self?.alert = true
                    }
                }
            }
        }
    }
    
    func updateEmail() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        if emailValidation() {
            connecting = true
            Auth.auth().currentUser?.updateEmail(to: email) { (error) in
                guard error == nil else {
                    self.alertType = .error
                    self.connecting = false
                    self.errorMessage = "エラーが発生しました。"
                    self.alert = true
                    return
                }
                CurrentUser().getIdToken { idToken in
                    let request = UserRequest().update(userId: id, email: self.email, idToken: idToken)
                    StudyLevelClient().send(request: request) { [weak self] result in
                        switch result {
                        case .success(_):
                            DispatchQueue.main.async {
                                self?.alertType = .updateSuccess
                                self?.connecting = false
                                self?.alert = true
                            }
                        case .failure(_):
                            DispatchQueue.main.async {
                                self?.alertType = .error
                                self?.connecting = false
                                self?.errorMessage = "通信エラーが発生しました。"
                                self?.alert = true
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updatePassword() {
        if passwordValidation() && confirmationPasswordValidation() {
            connecting = true
            Auth.auth().currentUser?.updatePassword(to: password) { (error) in
                if let error = error {
                    print(error)
                    self.alertType = .error
                    self.errorMessage = "エラーが発生しました。"
                    self.connecting = false
                    self.alert = true
                }
                self.alertType = .updateSuccess
                self.errorMessage = ""
                self.connecting = false
                self.alert = true
            }
        }
    }
    
    private func emailValidation() -> Bool {
        guard let id = CurrentUser().currentUser()?.id else {
            return false
        }
        let emailValidationResult = SignupValidation(userId: id).isValidEmail(email: email)
        switch emailValidationResult {
        case .success(_):
            emailValidationErrorMessage = ""
        case .failure(.emailIsRequired):
            emailValidationErrorMessage = "メールアドレスは必須項目です。"
        case .failure(.invalidEmail):
            emailValidationErrorMessage = "無効なメールアドレスです。"
        case .failure(.alreadyRegisteredEmail):
            emailValidationErrorMessage = "既に登録されているメールアドレスです。"
        case .failure(_):
            emailValidationErrorMessage = "エラーが発生しました。"
        }
        return emailValidationErrorMessage.isEmpty
    }
    
    private func passwordValidation() -> Bool {
        let passwordValidationResult = SignupValidation().isValidPassword(password: password)
        switch passwordValidationResult {
        case .success(_):
            passwordValidationErrorMessage = ""
        case .failure(.passwordIsRequired):
            passwordValidationErrorMessage = "パスワードは必須項目です。"
        case .failure(.passwordIsTooShort):
            passwordValidationErrorMessage = "パスワードは6文字以上にしてください。"
        case .failure(_):
            passwordValidationErrorMessage = "エラーが発生しました。"
        }
        return passwordValidationErrorMessage.isEmpty
    }
    
    private func confirmationPasswordValidation() -> Bool {
        let confirmationPasswordValidationResult = SignupValidation()
            .isValidConfirmationPassword(password: password, confirmationPassword: confirmationPassword)
        switch confirmationPasswordValidationResult {
        case .success(_):
            passwordValidationErrorMessage = ""
        case .failure(.confirmationPasswordIsRequired):
            passwordValidationErrorMessage = "パスワード（確認）は必須項目です。"
        case .failure(.confirmationAndPasswordDoNotMatch):
            passwordValidationErrorMessage = "パスワードとパスワード（確認）\nが一致しません。"
        case .failure(_):
            passwordValidationErrorMessage = "エラーが発生しました。"
        }
        return passwordValidationErrorMessage.isEmpty
    }
    
    enum AlertType {
        case updateSuccess
        case error
    }
}
