//
//  SearchUserListItem.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct SearchUserListItem: View {
    @ObservedObject var viewModel: SearchViewModel
    var user: SearchUser
    @State var error = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationLink(destination: UserPageView(id: user.id, error: $error, errorMessage: $errorMessage)) {
            HStack {
                VStack {
                    if let urlString = user.avatarURL {
                        if let url = URL(string: urlString) {
                            AvaterView(container: ImageContainer(from: url, userId: user.id),
                                       size: 30)
                        } else {
                            DefaultAvatarView(size: 30)
                        }
                    } else {
                        DefaultAvatarView(size: 30)
                    }
                }
                .padding()
                VStack {
                    HStack {
                        Text(user.name)
                            .foregroundColor(.primary)
                            .font(.callout)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("@" + (user.screenName))
                            .foregroundColor(.secondary)
                            .font(.caption)
                        Spacer()
                    }
                }
                HStack {
                    Text(String(user.experience.level))
                        .foregroundColor(Color(UIColor(hex: viewModel.levelColor(user: user))))
                    Text("level")
                        .font(.caption)
                        .foregroundColor(Color(UIColor(hex: viewModel.levelColor(user: user))))
                }
                .padding()
            }
        }
    }
}
