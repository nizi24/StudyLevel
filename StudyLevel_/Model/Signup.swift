//
//  Signup.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import Foundation
import FirebaseAuth

struct Signup {
    var name: String
    var email: String
    var password: String
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
        }
    }
}
