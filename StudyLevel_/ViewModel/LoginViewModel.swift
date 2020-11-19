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
    
    func login() {
        Login(email: email, password: password).login(failure: {
            self.errorMessage = "ログインに失敗しました"
        }, success: {
            self.isLogin = true
        })
    }
}
