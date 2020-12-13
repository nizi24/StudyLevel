//
//  ProfileView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: UserPageViewModel
    var userId: Int
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if let urlString = viewModel.user?.avatarURL, let id = viewModel.user?.id {
                        if let url = URL(string: urlString) {
                            AvaterView(container: ImageContainer(from: url, userId: id),
                                       size: 60)
                        } else {
                            DefaultAvatarView(size: 60)
                        }
                    } else {
                        DefaultAvatarView(size: 60)
                    }
                }
                .padding()
                VStack {
                    HStack {
                        Text(viewModel.user?.name ?? "")
                            .foregroundColor(.primary)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("@" + (viewModel.user?.screenName ?? ""))
                            .foregroundColor(.secondary)
                            .font(.caption)
                        Spacer()
                    }
                }
                if let currentUserId = CurrentUser().currentUser()?.id, currentUserId != userId {
                    FollowButtonView(viewModel: FollowButtonViewModel(), targetId: userId, following: $viewModel.isFollowing, followerCount: $viewModel.followerCount)
                        .padding(.trailing, 20)
                }
                Spacer()
            }
            HStack {
                Text(viewModel.user?.profile ?? "")
                    .font(.footnote)
                    .padding()
                Spacer()
            }
            HStack {
                HStack {
                    Text(String(viewModel.followingCount))
                        .bold()
                    Text("フォロー")
                        .font(.footnote)
                }
                .padding(.trailing, 20)
                HStack {
                Text(String(viewModel.followerCount))
                    .bold()
                Text("フォロワー")
                    .font(.footnote)
                }
                Spacer()
            }
            .padding(.leading)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: UserPageViewModel(id: 1), userId: 1)
    }
}
