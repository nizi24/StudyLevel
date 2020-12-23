//
//  AccountSettingView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import SwiftUI

struct AccountSettingView: View {
    @StateObject var viewModel = AccountSettingViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            Form {
                Section(header: Text("メールアドレス")) {
                    TextField("メールアドレス", text: $viewModel.email)
                    Button(action: {
                        viewModel.updateEmail()
                    }, label: { Text("変更") })
                    if !viewModel.emailValidationErrorMessage.isEmpty {
                        Text(viewModel.emailValidationErrorMessage)
                            .foregroundColor(.red)
                    }
                }
                Section(header: Text("パスワード")) {
                    TextField("パスワード", text: $viewModel.password)
                    TextField("パスワード（確認）", text: $viewModel.confirmationPassword)
                    Button(action: {
                        viewModel.updatePassword()
                    }, label: { Text("変更") })
                    if !viewModel.passwordValidationErrorMessage.isEmpty {
                        Text(viewModel.passwordValidationErrorMessage)
                            .foregroundColor(.red)
                    }
                }
            }
            .navigationBarTitle(Text("アカウント設定"), displayMode: .inline)
            .alert(isPresented: $viewModel.alert) {
                switch viewModel.alertType {
                case .updateSuccess:
                    return Alert(title: Text("完了"), message: Text("アカウント情報を変更しました。"), dismissButton: .default(Text("OK")))
                case .error:
                    return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
                }
            }
            .onAppear {
                viewModel.getEmail()
            }
        }
    }
}

struct AccountSettingView_Previews: PreviewProvider {
    static var previews: some View {
        AccountSettingView()
    }
}
