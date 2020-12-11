//
//  RankingUserListItem.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct RankingUserListItem: View {
    var rank: Int
    var user: RankingUser
    @Binding var error: Bool
    @Binding var errorMessage: String
    
    var body: some View {
        NavigationLink(destination: UserPageView(id: user.id, error: $error, errorMessage: $errorMessage)) {
            HStack {
                if rank == 1 {
                    Image(systemName: "crown")
                        .foregroundColor(Color(UIColor(hex: "ffc400")))
                        .padding(.leading, 25)
                } else if rank == 2 {
                    Image(systemName: "crown")
                        .foregroundColor(Color(UIColor(hex: "c9c9c9")))
                        .padding(.leading, 25)

                } else if rank == 3 {
                    Image(systemName: "crown")
                        .foregroundColor(Color(UIColor(hex: "ac6d4d")))
                        .padding(.leading, 25)
                } else {
                    Text(String(rank))
                        .font(.title2)
                        .foregroundColor(Color.black)
                        .bold()
                        .padding(.leading, 30)
                        .padding(.trailing, 5)
                }
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
                    Text(String(user.exp))
                        .foregroundColor(Color(UIColor(hex: "FF6F00")))
                    Text("exp")
                        .font(.caption)
                        .foregroundColor(Color(UIColor(hex: "FF6F00")))
                }
                .padding()
            }
        }
    }
}
