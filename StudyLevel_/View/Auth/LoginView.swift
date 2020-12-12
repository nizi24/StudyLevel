//
//  Login.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel = LoginViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                VStack {
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $viewModel.isLogin,
                        label: {
                            EmptyView()
                        })
                    Text("ログイン")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                        
                    Form {
                        TextField("メールアドレス", text: $viewModel.email)
                            .padding(10)
                        SecureField("パスワード", text: $viewModel.password)
                            .padding(10)
                    }.frame(height: 300)
                    if !viewModel.errorMessage.isEmpty {
                        Text("・" + viewModel.errorMessage)
                            .foregroundColor(Color.red)
                            .padding(.bottom, 10)
                    }
                    Button(action: {
                        viewModel.login()
                    }, label: {
                        Text("ログイン")
                            .font(.title3)
                            .fontWeight(.bold)
                    })
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    Spacer()
                }
            }
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginView()
        }
    }
}
