//
//  CommentView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct CommentView: View {
    @StateObject var viewModel = CommentViewModel()
    @Binding var comment: Comment
    @Binding var reload: Bool
    @State var changeLikesCount: Int = -1
    
    init(comment: Binding<Comment>, reload: Binding<Bool>) {
        self._comment = comment
        self._reload = reload
        changeLikesCount = -1
    }
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if let urlString = viewModel.proccessingLocalHostAvatarURL(comment: comment) {
                        if let url = URL(string: urlString) {
                            AvaterView(container: ImageContainer(from: url, userId: comment.creator.id),
                                       size: 30)
                        } else {
                            DefaultAvatarView(size: 30)
                        }
                    } else {
                        DefaultAvatarView(size: 30)
                    }
                }
                .padding()
                .padding(.leading, 20)
                VStack {
                    HStack {
                        Text(comment.creator.name)
                            .foregroundColor(.primary)
                            .font(.callout)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("@" + (comment.creator.screenName))
                            .foregroundColor(.secondary)
                            .font(.caption)
                        Spacer()
                    }
                }
                Spacer()
                if viewModel.displayDeleteButton(creatorId: comment.creator.id) {
                    Button(action: {
                        viewModel.deleteConfirm()
                    }, label: {
                        Image(systemName: "trash")
                    })
                    .padding(.trailing, 30)
                }
            }
            HStack {
                Text(comment.content)
                    .padding(.top, 15)
                    .padding(.leading, 50)
                    .padding(.trailing, 30)
                    .foregroundColor(Color.black)
                Spacer()
            }
            HStack {
                Spacer()
                CommentLikeButtonView(comment: comment, count: $changeLikesCount)
                Text(String(comment.likesCount))
                    .font(.caption)
            }
            .padding(.top, 15)
            .padding(.leading, 35)
            .padding(.trailing, 30)
            .padding(.bottom, 15)
            Divider()
            Text("")
            .alert(isPresented: $viewModel.aleat) {
                switch(viewModel.aleatType) {
                case .error:
                    return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage), dismissButton: .default(Text("OK"),action: {
                    }))
                case .deleteSuccess:
                    return Alert(title: Text("完了"), message: Text("コメントを削除しました。"), dismissButton: .default(Text("OK"), action: {
                        reload = true
                    }))
                case .confirmDelete:
                    return Alert(title: Text("確認"), message: Text("コメントを削除しますか？"), primaryButton: .cancel(Text("キャンセル")), secondaryButton: .destructive(Text("削除"), action: {
                        viewModel.delete(commentId: comment.id)
                    }))
                case .none:
                    return Alert(title: Text("エラー"))
                }
            }
        }
        .onChange(of: changeLikesCount) { changeLikesCount in
            if changeLikesCount == 0 {
                comment.likesCount -= 1
                self.changeLikesCount = -1
            } else if changeLikesCount == 1 {
                comment.likesCount += 1
                self.changeLikesCount = -1
            }
        }
    }
}
