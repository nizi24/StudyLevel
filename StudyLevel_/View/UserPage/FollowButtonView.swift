//
//  FollowButtonView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct FollowButtonView: View {
    @ObservedObject var viewModel = FollowButtonViewModel()
    var targetUserId: Int
    @Binding var following: Bool
    @Binding var followerCount: Int
    
    var body: some View {
        VStack {
            if following {
                Button(action: {
                    viewModel.unfollow(targetUserId: targetUserId)
                }, label: {
                    Text("フォロー中")
                        .font(.caption)
                })
                .padding(10)
                .background(Color.blue)
                .foregroundColor(Color.white)
            } else {
                Button(action: {
                    viewModel.follow(targetUserId: targetUserId)
                }, label: {
                    Text("フォロー")
                        .font(.caption)
                })
                .padding(10)
                .foregroundColor(Color.blue)
                .border(Color.blue)
            }
        }
        .onChange(of: viewModel.i) { i in
            if i == 10 {
                following = true
                followerCount += 1
                viewModel.i = 0
            } else if i == -10 {
                following = false
                followerCount -= 1
                viewModel.i = 0
            }
        }
    }
}

struct FollowButtonView_Previews: PreviewProvider {
    static var previews: some View {
        FollowButtonView(targetUserId: 0, following: .constant(true), followerCount: .constant(1))
    }
}
