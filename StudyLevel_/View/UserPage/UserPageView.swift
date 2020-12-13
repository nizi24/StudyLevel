//
//  MyPageView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct UserPageView: View {
    var id: Int
    @StateObject var viewModel: UserPageViewModel
    @Binding var error: Bool
    @Binding var errorMessage: String
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var title = "通信中・・・"
    @State var reload = false
    
    init(id: Int, error: Binding<Bool>, errorMessage: Binding<String>) {
        self.id = id
        _viewModel = StateObject(wrappedValue: UserPageViewModel(id: id))
        self._error = error
        self._errorMessage = errorMessage
    }
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    VStack {
                        ProfileView(viewModel: viewModel, userId: id)
                            .frame(height: 250)
                            .background(Color.white)
                            .padding()
                        ExperienceProgressView(viewModel: viewModel)
                            .frame(height: 100)
                            .padding()
                            .background(Color.white)
                        WeeklyTargetView(viewModel: viewModel)
                            .frame(height: 100)
                            .padding()
                            .background(Color.white)
                        Spacer()
                        VStack {
                            if let timeReports = viewModel.timeReports {
                                ForEach(timeReports.indices, id: \.self) { i in
                                    TimeReportView(timeReport: timeReports[i], reload: $reload, currentPageUserId: viewModel.user?.id)
                                        .background(Color.white)
                                }
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
                        if let currentUserId = CurrentUser().currentUser()?.id, currentUserId ==     id {
                            EmptyView()
                                .navigationBarItems(leading: Button(action: {
                                        viewModel.getToServer()
                                }, label: { Image(systemName: "goforward") }),
                                trailing: NavigationLink(destination: ProfileSettingView(name: viewModel.user?.name, screenName: viewModel.user?.screenName, profile: viewModel.user?.profile)) {
                                    Image(systemName: "gearshape")
                                })
                        } else {
                            EmptyView()
                                .navigationBarItems(leading: Button(action: {
                                        viewModel.getToServer()
                                }, label: { Image(systemName: "goforward") }))
                        }

                    }
                }
                .frame(width: screen.width * 19 / 20)
            }
        }
        .onAppear {
            viewModel.getToServer()
        }
        .onChange(of: reload) { reload in
            if reload {
                viewModel.getToServer()
                self.reload = false
            }
        }
        .onChange(of: viewModel.error) { error in
            if error {
                self.error = true
                errorMessage = viewModel.errorMessage
                viewModel.error = false
            }
        }
        .navigationBarTitle(Text(viewModel.user?.name ?? "ユーザーページ"), displayMode: .inline)
    }
}
