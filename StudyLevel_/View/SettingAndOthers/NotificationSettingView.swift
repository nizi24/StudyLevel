//
//  NotificationSettingView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import SwiftUI

struct NotificationSettingView: View {
    @ObservedObject var viewModel = NotificationSettingViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            Form {
                Toggle(isOn: $viewModel.commentNotice, label: {
                    Text("コメントされた時")
                })
                Toggle(isOn: $viewModel.followNotice, label: {
                    Text("フォローされた時")
                })
                Toggle(isOn: $viewModel.timeReportLikeNotice, label: {
                    Text("学習記録にいいねされた時")
                })
                Toggle(isOn: $viewModel.commentLikeNotice, label: {
                    Text("コメントにいいねされた時")
                })
            }
            .navigationBarTitle(Text("通知設定"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.updateSetting()
            }, label: { Text("変更") }))
            .alert(isPresented: $viewModel.alert, content: {
                switch viewModel.alertType {
                case .updateSuccess:
                    return Alert(title: Text("完了"), message: Text("設定を変更しました。"), dismissButton: .default(Text("OK")))
                case .error:
                    return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
                }
            })
            .onAppear {
                viewModel.getSetting()
            }
        }
    }
}

struct NotificationSettingView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationSettingView()
    }
}
