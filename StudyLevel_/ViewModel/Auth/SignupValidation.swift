//
//  SignupValidation.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/27.
//

import Foundation

struct SignupValidation {
    var viewModel: SignupViewModel?
    var userId: Int?
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
    }
    
    init(userId: Int) {
        self.userId = userId
    }
    
    init() {}
    
    func isValidWithViewModel() -> [Result<Bool, SignupError>] {
        return [isValidName(name: viewModel!.name), isValidEmail(email: viewModel!.email),
                isValidPassword(password: viewModel!.password),
                isValidConfirmationPassword(password: viewModel!.password, confirmationPassword: viewModel!.confirmationPassword)]
    }
    
    func isValidName(name: String) -> Result<Bool, SignupError> {
        if name.isEmpty {
            return .failure(.nameIsRequired)
        } else if name.count > 20 {
            return .failure(.nameIsTooLong)
        } else {
            return .success(true)
        }
    }
    
    func isValidEmail(email: String) -> Result<Bool, SignupError> {
        if email.isEmpty {
            return .failure(.emailIsRequired)
        } else if !isEmail(email: email) {
            return .failure(.invalidEmail)
        } else if emailAlreadyUsed(email: email) {
            return .failure(.alreadyRegisteredEmail)
        } else {
            return .success(true)
        }
    }
    
    private func isEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: email)
        return result
    }
    
    private func emailAlreadyUsed(email: String) -> Bool {
        var request = AlreadyUsedRequest()
        if let currentUserId = userId {
            request = request.emailAlreadyUsed(userId: currentUserId, email: email)
        } else {
            request = request.emailAlreadyUsed(email: email)
        }
        var alreadyUsed = true
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let used):
                alreadyUsed = used
            case .failure(_): break
            }
            semaphore.signal()
        }
        semaphore.wait()
        return alreadyUsed
    }
    
    func isValidPassword(password: String) -> Result<Bool, SignupError> {
        if password.isEmpty {
            return .failure(.passwordIsRequired)
        } else if password.count < 6 {
            return .failure(.passwordIsTooShort)
        } else {
            return .success(true)
        }
    }
    
    func isValidConfirmationPassword(password: String, confirmationPassword: String) -> Result<Bool, SignupError> {
        if confirmationPassword.isEmpty {
            return .failure(.confirmationPasswordIsRequired)
        } else if password != confirmationPassword {
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
