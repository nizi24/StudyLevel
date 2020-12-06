//
//  TimeReportDetailView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct TimeReportDetailView: View {
    @StateObject var viewModel: TimeReportDetailViewModel
    @ObservedObject var commentFormViewModel = CommentFormViewModel()
    @State var reload = false
    @State var title = "通信中・・・"
    @StateObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var navigationBarHidden = false
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            ZStack {
                NavigationView {
                    ScrollView(.vertical) {
                        TimeReportViewNonNavigationLink(timeReport: viewModel.timeReport, navigationBarHidden: $navigationBarHidden)
                        CommentFormView(timeReportId: viewModel.timeReport.id, viewModel: commentFormViewModel, reload: $reload)
                        if let comments = viewModel.comments {
                            ForEach(comments.indices, id: \.self) { i in
                                CommentView(comment: $viewModel.comments[i], reload: $reload)
                            }
                        }
                    }
                    .navigationBarHidden(true)
                    .onAppear {
                        viewModel.reload()
                        keyboardObserver.addObserver()
                        navigationBarHidden = false
                    }.onDisappear {
                        keyboardObserver.removeObserver()
                    }
                    .onChange(of: reload, perform: { reload in
                        if reload {
                            self.reload = false
                            viewModel.reload()
                        }
                    })
                }
                .alert(isPresented: $viewModel.error) {
                    Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
                }
                .navigationBarHidden(navigationBarHidden)
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
