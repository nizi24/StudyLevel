//
//  CommentLikeButtonView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct CommentLikeButtonView: View {
    @ObservedObject var viewModel = LikeButtonViewModel()
    var comment: Comment
    @Binding var count: Int
    
    var body: some View {
        VStack {
            if viewModel.liked(comment: comment) {
                Button(action: {
                    viewModel.unlike(comment: comment)
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                }
            } else {
                Button(action: {
                    viewModel.like(comment: comment)
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(Color.red)
                }
            }
        }
        .onChange(of: viewModel.i) { i in
            if i == 10 {
                count = 1
            } else if i == -10 {
                count = 0
            }
        }
    }
}
