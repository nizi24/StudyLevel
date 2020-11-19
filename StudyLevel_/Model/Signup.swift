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
    
    func signup(failure: @escaping (String) -> Void, success: @escaping (User) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let error = error {
                if let errCode = AuthErrorCode(rawValue: error._code) {
                    switch errCode {
                    case .invalidEmail:
                        failure("メールアドレスの形式が違います。")
                    case .emailAlreadyInUse:
                        failure("このメールアドレスはすでに使われています。")
                    case .weakPassword:
                        failure("パスワードは6文字以上で入力してください。")
                    default:
                        failure("エラーが起きました。\nしばらくしてから再度お試しください。")
                    }
                }
            } else if let authResult = authResult {
                let client = StudyLevelClient()
                let request = UserRequest().create(name: name, email: email, uid: authResult.user.uid)
                client.send(request: request) { result in
                    switch result {
                    case .success(let user):
                        success(user)
                    case .failure(_): break
                    }
                }
            }
        }
    }
}
