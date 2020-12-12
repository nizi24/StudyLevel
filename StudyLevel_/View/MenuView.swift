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
    @ObservedObject var viewModel = MenuViewModel()
    @State var error = false
    @State var errorMessage = ""
    
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
                TabView {
                    FeedView(isNotLogin: $viewModel.isNotLogin)
                    .tabItem {
                            VStack {
                                Image(systemName: "list.bullet")
                                Text("ホーム")
                            }
                        }
                        .navigationBarHidden(true)
                    CreateTimeReportView()
                        .tabItem {
                            VStack {
                                Image(systemName: "square.and.pencil")
                                Text("記録する")
                            }
                        }
                        .navigationBarHidden(true)
                    NavigationView {
                        UserPageView(id: currentUserId, error: $error, errorMessage: $errorMessage)
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("マイページ")
                        }
                    }
                    .navigationBarHidden(true)
                    .alert(isPresented: $error) {
                        Alert(title: Text("エラー"), message: Text(errorMessage), dismissButton: .default(Text("OK"), action: {
                            error = false
                        }))
                    }
                    NotificationView()
                        .tabItem {
                            VStack {
                                Image(systemName: "bell")
                                Text("通知")
                            }
                        }
                        .navigationBarHidden(true)
                    SettingAndOthersView(isLogin: $viewModel.isNotLogin)
                        .tabItem {
                            VStack {
                                Image(systemName: "gearshape")
                                Text("設定・その他")
                            }
                        }
                        .navigationBarHidden(true)
                    }
                    .navigationBarBackButtonHidden(true)
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
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
    }
}
