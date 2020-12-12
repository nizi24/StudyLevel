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
                destination: SignupOrLoginView(),
                isActive: $viewModel.isNotLogin,
                label: {
                    EmptyView()
                })
            if let currentUserId = CurrentUser().currentUser()?.id {
                TabView {
                    FeedView()
                    .tabItem {
                            VStack {
                                Image(systemName: "list.bullet")
                                Text("ホーム")
                            }
                        }
                    CreateTimeReportView()
                        .tabItem {
                            VStack {
                                Image(systemName: "square.and.pencil")
                                Text("記録する")
                            }
                        }
                    NavigationView {
                        UserPageView(id: currentUserId, error: $error, errorMessage: $errorMessage)
                    }
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("マイページ")
                        }
                    }
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
                    SettingAndOthersView(isLogin: $viewModel.isNotLogin)
                        .tabItem {
                            VStack {
                                Image(systemName: "gearshape")
                                Text("設定・その他")
                            }
                        }
                    }
                    .navigationBarBackButtonHidden(true)
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
