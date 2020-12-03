//
//  TimeReportDetailView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct TimeReportDetailView: View {
    var viewModel: TimeReportDetailViewModel
    @State var reload = false
    @State var connecting = false
    @State var title = "通信中・・・"
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        LoadingView(title: $title, isShowing: $connecting) {
            ZStack {
                ScrollView(.vertical) {
                    TimeReportViewNonNavigationLink(viewModel: TimeReportViewModel(timeReport: viewModel.timeReport),
                                                    reload: $reload, connecting: $connecting)
                    CommentFormView(timeReportId: viewModel.timeReport.id)
                }
                .onAppear {
                    viewModel.reload()
                    keyboardObserver.addObserver()
                }.onDisappear {
                    keyboardObserver.removeObserver()
                }
                if keyboardObserver.isShowing {
                    Button(action: {
                        UIApplication.shared.endEditing()
                    }, label: {
                        Text("閉じる")
                            .bold()
                    })
                    .frame(width: screen.width * 2,height: 50)
                    .background(Color(UIColor(hex: "B0BEC5")))
                    .position(x: screen.width - 50, y: screen.height - keyboardObserver.height - 115)
                }
            }
        }
    }
}
