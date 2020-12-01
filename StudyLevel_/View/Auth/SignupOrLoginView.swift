//
//  SignupOrLoginView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct SignupOrLoginView: View {
    @State var page = 0
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            NavigationView {
                VStack {
                    TabView(selection: $page) {
                        VStack {
                            Text("Welcome To StudyLevel！")
                                .font(.largeTitle)
                                .bold()
                            Text("StudyLevelは、学習時間に応じてレベルが上がる学習管理アプリです。")
                                .padding()
                                .font(.headline)
                            LottieView(filename: "8804-level-up-confetti-animation")
                                .tag(2)
                        }
                        .tag(0)
                        Text("aa")
                            .tag(1)
                        LottieView(filename: "8804-level-up-confetti-animation")
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                    .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
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
                    .padding(.bottom, 30)
                }
            }
            .background(Color.backgroundGray)
        }
    }
}

struct SignupOrLoginView_Previews: PreviewProvider {
    static var previews: some View {
        SignupOrLoginView()
    }
}
