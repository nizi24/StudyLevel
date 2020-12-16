//
//  UserTagDetailView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/14.
//

import SwiftUI

struct UserTagDetailView: View {
    var user: User
    @StateObject var viewModel: UserTagDetailViewModel
    @State var title = "通信中・・・"
    @State var screen: CGSize = UIScreen.main.bounds.size
    @ObservedObject var keyboardObserver = KeyboardObserver()
    
    init(user: User) {
        self.user = user
        _viewModel = StateObject(wrappedValue: UserTagDetailViewModel(id: user.id))
    }
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    if let mainTags = viewModel.mainTags {
                        MainTagsView(user: user, mainTags: mainTags)
                            .background(Color.white)
                            .padding()
                    }
                    if let followingTags = viewModel.followingTags {
                        FollowingTagsView(user: user, followingTags: followingTags)
                            .background(Color.white)
                            .padding()
                    }
                    SearchTimeReportWithTagView(user: user)
                        .background(Color.white)
                        .padding()
                }
                .frame(width: screen.width * 19 / 20)
                .onAppear {
                    viewModel.getToServer()
                }
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
        .onAppear {
            keyboardObserver.addObserver()
        }
        .onDisappear {
            keyboardObserver.removeObserver()
        }
    }
}
