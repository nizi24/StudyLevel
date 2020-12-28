//
//  ReAuthViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/22.
//

import Foundation
import FirebaseAuth

class ReAuthViewModel: ObservableObject {
    @Published var password = ""
    @Published var connecting = false
    @Published var success = false
    @Published var errorMessage = ""
    
    func reAuth() {
        connecting = true
        let user = Auth.auth().currentUser
        guard let email = user?.email else {
            errorMessage = "エラーが発生しました。\nログアウトして再度お試しください。"
            return
        }
        Login(email: email, password: password).login(failure: {
            self.errorMessage = "ログインに失敗しました。"
            self.connecting = false
        }, success: {
            self.connecting = false
            self.password = ""
            self.errorMessage = ""
            self.success = true
        })
    }
}
