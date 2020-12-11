//
//  SignupValidation.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/27.
//

import Foundation

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
