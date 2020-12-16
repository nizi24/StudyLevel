//
//  ProfileFormValidation.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/13.
//

import Foundation

class ProfileFormValidation {
    
    func isValid(name: String, screenName: String, profile: String) -> [ValidationError?] {
        return [isValidName(name: name), isValidScreenName(screenName: screenName), isValidProfile(profile: profile)]
    }
    
    private func isValidName(name: String) -> ValidationError? {
        if name.count > 20 {
            return .nameIsTooLong
        } else if name.isEmpty {
            return .nameIsRequired
        }
        return nil
    }
    
    private func isValidScreenName(screenName: String) -> ValidationError? {
        if screenName.isEmpty {
            return .screenNameIsRequired
        } else if screenName.count < 5 {
            return .screenNameIsTooShort
        } else if screenName.count > 15 {
            return .screenNameIsTooLong
        } else if !regexScreenNameValidation(screenName: screenName) {
            return .screenNameIsNotValid
        } else if screenNameAlreadyUsed(screenName: screenName) {
            return .screenNameIsUsed
        }
        return nil
    }
    
    private func isValidProfile(profile: String) -> ValidationError? {
        if profile.count > 160 {
            return .profileIsTooLong
        }
        return nil
    }
    
    private func regexScreenNameValidation(screenName: String) -> Bool {
        let screenNameRegex = "[a-zA-Z0-9_]+"
        let screenNameTest = NSPredicate(format:"SELF MATCHES %@", screenNameRegex)
        let result = screenNameTest.evaluate(with: screenName)
        return result
    }
    
    private func screenNameAlreadyUsed(screenName: String) -> Bool {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            return true
        }
        let request = ScreenNameAlreadyUsedRequest().screenNameAlreadyUsed(userId: currentUserId, screenName: screenName)
        var alreadyUsed = true
        let semaphore = DispatchSemaphore(value: 0)
        StudyLevelClient().send(request: request) { result in
            switch (result) {
            case .success(let already):
                alreadyUsed = already
            case .failure(_):
                alreadyUsed = true
            }
            semaphore.signal()
        }
        semaphore.wait()
        return alreadyUsed
    }
    
    enum ValidationError: Error {
        case nameIsTooLong
        case nameIsRequired
        case screenNameIsNotValid
        case screenNameIsTooLong
        case screenNameIsTooShort
        case screenNameIsRequired
        case screenNameIsUsed
        case profileIsTooLong
    }
}
