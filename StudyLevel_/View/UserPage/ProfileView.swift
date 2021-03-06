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
    @State var screen: CGSize = UIScreen.main.bounds.size
    
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
            if let profile = viewModel.user?.profile, !profile.isEmpty, !BlockDB().find(userId: viewModel.id) {
                HStack {
                    Text(profile)
                        .font(.footnote)
                        .padding()
                        .frame(maxHeight: screen.height * 3 / 5)
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
            }
            HStack {
                NavigationLink(destination: FollowingView(user: viewModel.user)) {
                    HStack {
                        Text(String(viewModel.followingCount))
                            .bold()
                        Text("フォロー")
                            .font(.footnote)
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .foregroundColor(.primary)
                }
                NavigationLink(destination: FollowersView(user: viewModel.user)) {
                    HStack {
                        Text(String(viewModel.followerCount))
                            .bold()
                        Text("フォロワー")
                            .font(.footnote)
                    }
                    .padding(.bottom, 20)
                    .foregroundColor(.primary)
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
