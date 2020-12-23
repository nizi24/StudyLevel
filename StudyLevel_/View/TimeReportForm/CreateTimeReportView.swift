//
//  CreateTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI
import PartialSheet

struct CreateTimeReportView: View {
    @ObservedObject var viewModel = CreateTimeReportViewModel()
    @State var timeReportFormViewModel = TimeReportFormViewModel()
    @StateObject var keyboardObserver = KeyboardObserver()
    @State var title = "通信中・・・"
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            NavigationView {
                TimeReportFormView(viewModel: timeReportFormViewModel, keybord: keyboardObserver)
                    .navigationBarTitle(Text("記録を追加"), displayMode: .inline)
                    .navigationBarItems(trailing: Button(action: {
                        viewModel.create(timeReportFormViewModel: timeReportFormViewModel)
                        }, label: {
                            Text("追加")
                        })
                    )
                    .alert(isPresented: $viewModel.error) {
                        Alert(title: Text("エラー"), message: Text(viewModel.errorMessage ?? "エラー"), dismissButton: .destructive(Text("OK")))
                    }
            }
            .onAppear{
                keyboardObserver.addObserver()
            }.onDisappear {
                keyboardObserver.removeObserver()
            }
            .alert(isPresented: $viewModel.success) {
                Alert(title: Text("完了"), message: Text("記録を作成しました。"), dismissButton: .default(Text("OK"), action: {
                    self.timeReportFormViewModel = TimeReportFormViewModel()
                }))
            }
        }
    }
}

struct CreateTimeReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTimeReportView()
        }
    }
}
