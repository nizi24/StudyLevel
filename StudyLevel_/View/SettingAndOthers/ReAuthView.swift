//
//  ReAuthView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/22.
//

import SwiftUI

struct ReAuthView: View {
    @StateObject var viewModel = ReAuthViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            VStack {
                Form {
                    Section {
                        Text("重要なアカウント情報を更新するには再ログインが必要です。")
                    }
                    Section(header: Text("パスワード")) {
                        SecureField("パスワード", text: $viewModel.password)
                    }
                    if !viewModel.errorMessage.isEmpty {
                        Section {
                            Text(viewModel.errorMessage)
                                .foregroundColor(.red)
                        }
                    }
                }
                NavigationLink(destination: AccountSettingView(), isActive: $viewModel.success) {
                    EmptyView()
                }
            }
            .navigationBarTitle(Text("再ログイン"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.reAuth()
            }, label: {
                Text("ログイン")
            }))
        }
    }
}

struct ReAuthView_Previews: PreviewProvider {
    static var previews: some View {
        ReAuthView()
    }
}
