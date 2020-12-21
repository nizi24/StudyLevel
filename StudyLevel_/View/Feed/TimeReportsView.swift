//
//  NewestView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct TimeReportsView<ViewModel>: View where ViewModel: TimeReportsViewModelProtocol {
    @Binding var error: Bool
    @Binding var errorMessage: String
    @StateObject var viewModel: ViewModel
    @Binding var bindReload: Bool
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var reload = false
    @State var title = "通信中・・・"
    
    init(error: Binding<Bool>, errorMessage: Binding<String>, viewModel: ViewModel) {
        self._error = error
        self._errorMessage = errorMessage
        _viewModel = StateObject(wrappedValue: viewModel)
        self._bindReload = .constant(false)
    }
    
    init(error: Binding<Bool>, errorMessage: Binding<String>, viewModel: ViewModel, reload: Binding<Bool>) {
        self._error = error
        self._errorMessage = errorMessage
        _viewModel = StateObject(wrappedValue: viewModel)
        _bindReload = reload
    }

    var body: some View {
        VStack {
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    VStack {
                        VStack {
                            Text(viewModel.message)
                                .padding()
                            Text(viewModel.subMessage)
                                .padding(.horizontal)
                                .foregroundColor(.secondary)
                                .font(.callout)
                        }
                        .frame(width: screen.width * 19 / 20)
                        if let timeReports = viewModel.timeReports {
                            ForEach(timeReports.indices, id: \.self) { i in
                                TimeReportView(timeReport: timeReports[i], reload: $reload, currentPageUserId: nil)
                                    .background(Color.white)
                            }
                        }
                        if let timeReports = viewModel.timeReports {
                            if !timeReports.isEmpty && timeReports.count % 30 == 0 {
                                Button(action: {
                                    viewModel.getTimeReportMore()
                                }, label: {
                                    Text("もっと見る")
                                            .fontWeight(.semibold)
                                            .padding()
                                            .frame(width: 160, height: 48)
                                            .foregroundColor(Color(.blue))
                                            .background(Color(.white))
                                            .cornerRadius(24)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 24)
                                                    .stroke(Color(.blue), lineWidth: 1.0)
                                            )
                                })
                            }
                        }
                        Spacer()
                    }
                }
                .frame(width: screen.width * 19 / 20)
            }
            .onChange(of: reload) { reload in
                if reload {
                    viewModel.getTimeReports()
                    self.reload = false
                    self.bindReload = true
                }
            }
            .onChange(of: viewModel.error) { error in
                if error {
                    self.error = true
                    errorMessage = viewModel.errorMessage
                    viewModel.error = false
                }
            }
            .onAppear {
                viewModel.getTimeReports()
            }
        }
    }
}
