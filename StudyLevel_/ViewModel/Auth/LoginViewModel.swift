//
//  LoginViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var isLogin = false
    @Published var errorMessage = ""
    @Published var connecting = false
    
    func login() {
        connecting = true
        Login(email: email, password: password).login(failure: {
            self.errorMessage = "ログインに失敗しました"
            self.connecting = false
        }, success: {
            self.email = ""
            self.password = ""
            self.errorMessage = ""
            self.isLogin = true
            self.connecting = false
        })
    }
}
