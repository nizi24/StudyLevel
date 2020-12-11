//
//  SignupOrLoginView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct SignupOrLoginView: View {
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    Text("Welcome To StudyLevel！")
                        .font(.largeTitle)
                        .bold()
                    Text("StudyLevelは、学習時間に応じてレベルが上がる学習管理アプリです。")
                        .padding()
                        .font(.headline)
                    NavigationLink(destination: SignupView()) {
                        Text("いますぐ始める")
                        .font(.title3)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(10)
                    }
                    NavigationLink(destination: LoginView()) {
                        Text("すでにアカウントをお持ちの方")
                        .padding()
                    }
                }
            }.navigationBarHidden(true)
        }
    }
}

struct SignupOrLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignupOrLoginView()
    }
}
