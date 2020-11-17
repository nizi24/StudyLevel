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
    
    func signup() {
        errorMessages = []
        createErrorMessages()
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

struct SignupValidation {
    var viewModel: SignupViewModel
    
    func isValid() -> [Result<Bool, SignupError>] {
        return [isValidName(), isValidEmail(), isValidPassword(), isValidConfirmationPassword()]
    }
    
    func isValidName() -> Result<Bool, SignupError> {
        if viewModel.name.isEmpty {
            return .failure(.nameIsRequired)
        } else if viewModel.name.count > 20 {
            return .failure(.nameIsTooLong)
        } else {
            return .success(true)
        }
    }
    
    func isValidEmail() -> Result<Bool, SignupError> {
        if viewModel.email.isEmpty {
            return .failure(.emailIsRequired)
        } else if isEmail() {
            return .success(true)
        } else {
            return .failure(.invalidEmail)
        }
    }
    
    private func isEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: viewModel.email)
        return result
    }
    
    func isValidPassword() -> Result<Bool, SignupError> {
        if viewModel.password.isEmpty {
            return .failure(.passwordIsRequired)
        } else if viewModel.password.count < 6 {
            return .failure(.passwordIsTooShort)
        } else {
            return .success(true)
        }
    }
    
    func isValidConfirmationPassword() -> Result<Bool, SignupError> {
        if viewModel.confirmationPassword.isEmpty {
            return .failure(.confirmationPasswordIsRequired)
        } else if viewModel.password != viewModel.confirmationPassword {
            return .failure(.confirmationAndPasswordDoNotMatch)
        } else {
            return .success(true)
        }
    }
    
    enum SignupError: Error {
        case nameIsRequired
        case nameIsTooLong
        case emailIsRequired
        case invalidEmail
        case alreadyRegisteredEmail
        case passwordIsRequired
        case passwordIsTooShort
        case confirmationPasswordIsRequired
        case confirmationAndPasswordDoNotMatch
    }
}
