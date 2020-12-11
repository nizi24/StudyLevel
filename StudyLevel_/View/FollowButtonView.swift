//
//  FollowButtonView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct FollowButtonView<ViewModel>: View where ViewModel: FollowButtonViewModelProtocol {
    @ObservedObject var viewModel: ViewModel
    var targetId: Int
    @Binding var following: Bool
    @Binding var followerCount: Int
    
    var body: some View {
        VStack {
            if following {
                Button(action: {
                    viewModel.unfollow(targetId: targetId)
                }, label: {
                    Text("フォロー中")
                        .font(.caption)
                })
                .padding(10)
                .background(Color.blue)
                .foregroundColor(Color.white)
            } else {
                Button(action: {
                    viewModel.follow(targetId: targetId)
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
