//
//  TagProfileView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct TagProfileView: View {
    @ObservedObject var viewModel: TagPageViewModel
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(viewModel.tagPage.name)
                    .font(.title2)
                    .bold()
                Spacer()
            }
            FollowButtonView(viewModel: TagFollowButtonViewModel(), targetId: viewModel.tagPage.id, following: $viewModel.tagPage.following, followerCount: $viewModel.tagPage.followerCount)
            HStack {
                Spacer()
                HStack {
                    Text(String(viewModel.tagPage.followerCount))
                        .bold()
                    Text("フォロワー")
                        .font(.footnote)
                }
                .padding(.trailing, 20)
                HStack {
                    Text(String(viewModel.tagPage.timeReportCount))
                    .bold()
                Text("投稿")
                    .font(.footnote)
                }
                Spacer()
            }
            .padding(.leading)
        }
    }
}
