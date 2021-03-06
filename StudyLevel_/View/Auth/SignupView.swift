//
//  SignupView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel = SignupViewModel()
    @State var title = "通信中・・・"
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView {
                    NavigationLink(
                        destination: ContentView(),
                        isActive: $viewModel.complete) {
                        EmptyView()
                    }
                    Text("新規登録")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.top, 30)
                    Form {
                        TextField("名前", text: $viewModel.name)
                            .padding(10)
                        TextField("メールアドレス", text: $viewModel.email)
                            .padding(10)
                        SecureField("パスワード", text: $viewModel.password)
                            .padding(10)
                        SecureField("パスワードの確認", text: $viewModel.confirmationPassword)
                            .padding(10)
                    }.frame(height: 300)
                    ForEach(viewModel.errorMessages.indices, id: \.self) { i in
                        Text("・" + viewModel.errorMessages[i])
                            .foregroundColor(Color.red)
                            .padding(.bottom, 10)
                    }
                    VStack {
                        HStack {
                            NavigationLink(destination: RoleView()) {
                                Text("利用規約")
                            }
                            Text(" 及び ")
                            NavigationLink(destination: PrivacyView()) {
                                Text("プライバシーポリシー")
                            }
                        }
                        Text("に同意の上ご利用ください。")
                    }
                    .font(.footnote)
                    .padding(.bottom, 30)
                    Button(action: {
                        viewModel.signup()
                    }, label: {
                        Text("登録する")
                            .font(.title3)
                            .fontWeight(.bold)
                    })
                    .padding(10)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    Spacer()
                }
                .frame(width: screen.width * 19 / 20)
            }
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SignupView()
        }
    }
}
