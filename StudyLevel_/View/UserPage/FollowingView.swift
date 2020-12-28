//
//  FollowingView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import SwiftUI

struct FollowingView: View {
    var user: User?
    @ObservedObject var viewModel = FollowingViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        if let user = user {
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    HStack {
                        Text("\(user.name)さんがフォローしているユーザー")
                            .bold()
                            .padding()
                        Spacer()
                    }
                    Divider()
                    if let users = viewModel.followingUser, !users.isEmpty {
                        ForEach(users.indices, id: \.self) { i in
                            SearchUserListItem(user: users[i])
                            Divider()
                        }
                    } else {
                        Text("まだフォローしていません。")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .onAppear {
                    viewModel.getFollowingUser(userId: user.id)
                }
                
            }
        }
    }
}
