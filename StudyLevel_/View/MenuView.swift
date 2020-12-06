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
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: SignupOrLoginView(),
                isActive: $viewModel.isNotLogin,
                label: {
                    EmptyView()
                })
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
                MyPageView()
                    .tabItem {
                        VStack {
                            Image(systemName: "person.crop.circle")
                            Text("マイページ")
                        }
                    }
                NotificationView()
                    .tabItem {
                        VStack {
                            Image(systemName: "bell")
                            Text("通知")
                        }
                    }
                OtherMenuView()
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

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
    }
}
