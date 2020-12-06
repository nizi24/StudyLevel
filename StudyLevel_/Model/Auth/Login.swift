//
//  Login.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation
import FirebaseAuth

struct Login {
    var email: String
    var password: String
    
    func login(failure: @escaping () -> Void, success: @escaping () -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if error != nil  {
                failure()
            } else if authResult != nil {
                success()
            }
        }
    }
}
