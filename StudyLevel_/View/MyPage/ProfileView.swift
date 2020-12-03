//
//  ProfileView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
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
                Spacer()
            }
            Text(viewModel.user?.profile ?? "このアプリの作者です。 ツイッターでも学習報告してますが、こちらでも毎日学習報告する予定。")
                .font(.footnote)
                .padding()
            HStack {
                HStack {
                    Text(String(viewModel.followingCount ?? 10))
                        .bold()
                    Text("フォロー")
                        .font(.footnote)
                }
                .padding(.trailing, 20)
                HStack {
                Text(String(viewModel.followerCount ?? 10))
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
        ProfileView(viewModel: MyPageViewModel())
    }
}
