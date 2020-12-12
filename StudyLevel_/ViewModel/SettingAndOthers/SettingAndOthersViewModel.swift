//
//  SettingAndOthersViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation
import FirebaseAuth

class SettingAndOthersViewModel: ObservableObject {
    
    func logout() -> Bool {
        do {
            try Auth.auth().signOut()
            CurrentUser().removeCurrentUser()
            return true
        } catch {
            return false
        }
    }
}
