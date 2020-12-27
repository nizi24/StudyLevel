//
//  SettingAndOthersView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct SettingAndOthersView: View {
    @ObservedObject var viewModel = SettingAndOthersViewModel()
    @Binding var isLogin: Bool
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("設定")) {
                    NavigationLink(destination: ReAuthView()) {
                        Text("アカウント設定")
                    }
                    NavigationLink(destination: NotificationSettingView()) {
                        Text("通知設定")
                    }
                }
                Section(header: Text("規約")) {
                    NavigationLink(destination: RoleView()) {
                        Text("利用規約")
                    }
                    NavigationLink(destination: PrivacyView()) {
                        Text("プライバシーポリシー")
                    }
                }
                Section(header: Text("その他")) {
                    Button(action: {
                        if viewModel.logout() {
                            isLogin = false
                        }
                    }, label: {
                        Text("ログアウト")
                    })
                }
            }
            .navigationBarTitle(Text("設定・その他"), displayMode: .inline)
        }
    }
}

struct SettingAndOthersView_Previews: PreviewProvider {
    static var previews: some View {
        SettingAndOthersView(isLogin: .constant(true))
    }
}
