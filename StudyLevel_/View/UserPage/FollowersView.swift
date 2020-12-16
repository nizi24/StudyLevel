//
//  FollowersView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/16.
//

import SwiftUI

struct FollowersView: View {
    var user: User?
    @ObservedObject var viewModel = FollowersViewModel()
    @State var title = "通信中・・・"
    
    var body: some View {
        if let user = user {
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    HStack {
                        Text("\(user.name)さんをフォローしているユーザー")
                            .bold()
                            .padding()
                        Spacer()
                    }
                    Divider()
                    if let users = viewModel.followers, !users.isEmpty {
                        ForEach(users.indices, id: \.self) { i in
                            SearchUserListItem(user: users[i])
                            Divider()
                        }
                    } else {
                        Text("まだフォローされていません。")
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .padding()
                    }
                }
                .onAppear {
                    viewModel.getFollowers(userId: user.id)
                }
                
            }
        }

    }
}

struct FollowersView_Previews: PreviewProvider {
    static var previews: some View {
        FollowersView()
    }
}
