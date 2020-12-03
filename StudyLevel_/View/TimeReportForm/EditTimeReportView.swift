//
//  EditTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/30.
//

import SwiftUI

struct EditTimeReportView: View {
    @ObservedObject var viewModel = EditTimeReportViewModel()
    @State var timeReportFormViewModel: TimeReportFormViewModel
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var title = "通信中・・・"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            NavigationView {
                TimeReportFormView(viewModel: timeReportFormViewModel, keybord: keyboardObserver)
                    .alert(isPresented: $viewModel.error) {
                        Alert(title: Text("エラー"), message: Text(viewModel.errorMessage ?? "エラー"), dismissButton: .destructive(Text("OK")))
                    }
                    .onAppear{
                        keyboardObserver.addObserver()
                    }.onDisappear {
                        keyboardObserver.removeObserver()
                    }
                    .navigationBarHidden(true)
            }
            .navigationBarTitle(Text("記録を変更"), displayMode: .inline)
            .navigationBarItems(trailing: Button(action: {
                viewModel.update(timeReportFormViewModel: timeReportFormViewModel)
            }, label: {
                Text("変更")
            }))
            .alert(isPresented: $viewModel.success) {
                Alert(title: Text("完了"), message: Text("記録を変更しました。"), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }))
            }
        }
    }
}
