//
//  TimeReportDetailView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct TimeReportDetailView: View {
    @StateObject var viewModel: TimeReportDetailViewModel
    @Binding var error: Bool
    @Binding var errorMessage: String
    @ObservedObject var commentFormViewModel = CommentFormViewModel()
    @State var reload = false
    @State var title = "通信中・・・"
    @StateObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @Environment(\.presentationMode) var presentationMode
            
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            ZStack {
                if let timeReport = viewModel.timeReport {
                    ScrollView(.vertical) {
                        TimeReportViewNonNavigationLink(timeReport: timeReport)
                        CommentFormView(timeReportId: timeReport.id, viewModel: commentFormViewModel, reload: $reload)
                        if let comments = viewModel.comments {
                            ForEach(comments.indices, id: \.self) { i in
                                CommentView(comment: $viewModel.comments[i], reload: $reload)
                            }
                        }
                    }
                    .onAppear {
                        viewModel.reload()
                        keyboardObserver.addObserver()
                    }.onDisappear {
                        keyboardObserver.removeObserver()
                    }
                    .onChange(of: viewModel.error) { error in
                        if error {
                            self.error = true
                            self.errorMessage = viewModel.errorMessage
                            viewModel.error = false
                        }
                    }
                    .onChange(of: reload, perform: { reload in
                        if reload {
                            self.reload = false
                            viewModel.reload()
                        }
                    })
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
