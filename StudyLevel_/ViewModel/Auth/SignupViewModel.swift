//
//  SignupViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import Foundation
import FirebaseAuth

class SignupViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmationPassword = ""
    @Published var errorMessages: [String] = []
    @Published var complete = false
    @Published var connecting = false
    
    func signup() {
        connecting = true
        errorMessages = []
        createErrorMessages()
        if errorMessages.isEmpty {
            Signup(name: name, email: email, password: password).signup(failure: { error in
                self.errorMessages.append(error)
                self.connecting = false
            }) { user in
                self.complete = true
                self.connecting = false
                self.reset()
            }
        } else {
            connecting = false
        }
    }
    
    private func reset() {
        name = ""
        email = ""
        password = ""
        confirmationPassword = ""
        errorMessages = []
    }
    
    private func createErrorMessages() {
        let validationResults = SignupValidation(viewModel: self).isValid()
        for validationResult in validationResults {
            switch validationResult {
            case .success(true): break
            case let .failure(error):
                switch error {
                case .nameIsRequired:
                    errorMessages.append("名前は必須項目です")
                case .nameIsTooLong:
                errorMessages.append("名前は20文字以内にしてください")
                case .emailIsRequired:
                    errorMessages.append("メールアドレスは必須項目です")
                case .invalidEmail:
                    errorMessages.append("無効なメールアドレスです")
                case .alreadyRegisteredEmail:
                    errorMessages.append("既に登録されたメールアドレスです")
                case .passwordIsRequired:
                    errorMessages.append("パスワードは必須項目です")
                case .passwordIsTooShort:
                    errorMessages.append("パスワードは6文字以上にしてください")
                case .confirmationPasswordIsRequired:
                    errorMessages.append("パスワード(確認用)は必須項目です")
                case .confirmationAndPasswordDoNotMatch:
                    errorMessages.append("パスワードと確認が一致しません")
                }
            default:
                fatalError()
            }
        }
    }
    
}
