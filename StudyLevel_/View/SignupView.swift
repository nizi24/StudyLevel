//
//  SignupView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI

struct SignupView: View {
    @ObservedObject var viewModel = SignupViewModel()
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("新規登録")
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.top, 30)
                    
                Form {
                    TextField("名前", text: $viewModel.name)
                        .padding(10)
                    TextField("メールアドレス", text: $viewModel.email)
                        .padding(10)
                    TextField("パスワード", text: $viewModel.password)
                        .padding(10)
                    TextField("パスワードの確認", text: $viewModel.confirmationPassword)
                        .padding(10)
                }.frame(height: 300)
                ForEach(viewModel.errorMessages.indices, id: \.self) { i in
                    Text("・" + viewModel.errorMessages[i])
                        .foregroundColor(Color.red)
                        .padding(.bottom, 10)
                }
                Text("利用規約 及び プライバシーポリシー に同意の上ご利用ください。")
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
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
