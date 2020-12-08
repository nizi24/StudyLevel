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
                            HStack {
                                Text("Welcome To")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color(UIColor(hex: "FFD54F")))
                                Text("StudyLevel！")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color(UIColor(hex: "FF6F00")))
                            }
                            Text("StudyLevelは、学習時間に応じてレベルが上がる学習管理アプリです。")
                                .padding()
                                .font(.headline)
                            LottieView(filename: "28893-book-loading")
                        }
                        .tag(0)
                        VStack {
                            Text("モチベーションを保とう")
                                .foregroundColor(.secondary)
                                .font(.title)
                                .bold()
                                .padding()
                            Text("学習時間に応じて")
                                .foregroundColor(.blue)
                                .font(.title)
                                .bold()
                                .padding(.horizontal)
                            Text("レベルアップ！")
                                .foregroundColor(.blue)
                                .font(.title)
                                .bold()
                            LottieView(filename: "8804-level-up-confetti-animation")
                        }
                        .tag(1)
                        VStack {
                            Text("交流しよう")
                                .foregroundColor(.secondary)
                                .font(.title)
                                .bold()
                                .padding()
                            Text("いいねやコメントをしよう")
                                .foregroundColor(.blue)
                                .font(.title)
                                .bold()
                                .padding(.horizontal)
                            LottieView(filename: "13450-like-animation")
                        }
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
