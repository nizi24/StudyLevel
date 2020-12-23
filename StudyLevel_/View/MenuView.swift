//
//  MenuView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct MenuView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @ObservedObject var viewModel = MenuViewModel()
    @State var error = false
    @State var errorMessage = ""
    @State var selection = 0
    @StateObject var keyboardObserver = KeyboardObserver()
    
    init(contentViewModel: ContentViewModel) {
        _contentViewModel = ObservedObject(initialValue: contentViewModel)
    }
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: ContentView(),
                isActive: $viewModel.isNotLogin,
                label: {
                    EmptyView()
                        .navigationBarHidden(true)
                })
            if let currentUserId = CurrentUser().currentUser()?.id {
                TabView(selection: $selection) {
                    FeedView(isNotLogin: $viewModel.isNotLogin)
                        .tag(0)
                        .navigationBarHidden(true)
                    CreateTimeReportView()
                        .tag(1)
                        .navigationBarHidden(true)
                    NavigationView {
                        UserPageView(id: currentUserId, error: $error, errorMessage: $errorMessage)
                    }
                        .tag(2)
                        .navigationBarHidden(true)
                        .alert(isPresented: $error) {
                            Alert(title: Text("エラー"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                                error = false
                            }))
                        }
                    NotificationView(contentViewModel: contentViewModel)
                        .tag(3)
                        .navigationBarHidden(true)
                    SettingAndOthersView(isLogin: $viewModel.isNotLogin)
                        .tag(4)
                        .navigationBarHidden(true)
                    }
                    .navigationBarBackButtonHidden(true)
                    if !keyboardObserver.isShowing {
                        VStack {
                            Spacer(minLength: 0)
                            HStack {
                                VStack {
                                    Image(systemName: "list.bullet")
                                        .padding(.bottom, 1)
                                    Text("ホーム")
                                        .font(.caption2)
                                }
                                .foregroundColor(selection == 0 ? .blue : .secondary)
                                .onTapGesture {
                                    selection = 0
                                }
                                .padding(.leading, 15)
                                .padding(.trailing, 5)
                                Spacer()
                                VStack {
                                    Image(systemName: "square.and.pencil")
                                        .padding(.bottom, 1)
                                    Text("記録する")
                                        .font(.caption2)
                                }
                                .foregroundColor(selection == 1 ? .blue : .secondary)
                                .onTapGesture {
                                    selection = 1
                                }
                                .padding(.horizontal, 5)
                                Spacer()
                                VStack {
                                    Image(systemName: "person.crop.circle")
                                        .padding(.bottom, 1)
                                    Text("マイページ")
                                        .font(.caption2)
                                }
                                .foregroundColor(selection == 2 ? .blue : .secondary)
                                .onTapGesture {
                                    selection = 2
                                }
                                .padding(.horizontal, 5)
                                Spacer()
                                VStack {
                                    Image(systemName: contentViewModel.noticesIncludeNonChecked() || !contentViewModel.prevWeeklyTargetCheck ? "bell.badge.fill" : "bell")
                                        .padding(.bottom, 1)
                                        .foregroundColor(contentViewModel.noticesIncludeNonChecked() || !contentViewModel.prevWeeklyTargetCheck ? .orange : .secondary)
                                    Text("通知")
                                        .font(.caption2)
                                }
                                .foregroundColor(selection == 3 ? .blue : .secondary)
                                .onTapGesture {
                                    selection = 3
                                }
                                .padding(.horizontal, 5)
                                Spacer()
                                VStack {
                                    Image(systemName: "gearshape")
                                        .padding(.bottom, 1)
                                    Text("設定・その他")
                                        .font(.caption2)
                                }
                                .foregroundColor(selection == 4 ? .blue : .secondary)
                                .onTapGesture {
                                    selection = 4
                                }
                                .padding(.leading, 5)
                                .padding(.trailing, 10)
                            }
                            .foregroundColor(.secondary)
                        }
                    }
            } else {
                SignupOrLoginView()
                    .navigationBarHidden(true)
            }
        }
        .onChange(of: error) { error in
            if error && viewModel.isNotLogin {
                self.error = false
            }
        }
        .onAppear{
            keyboardObserver.addObserver()
        }.onDisappear {
            keyboardObserver.removeObserver()
        }
    }
}
