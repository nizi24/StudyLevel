//
//  FollowingTagsView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/15.
//

import SwiftUI

struct FollowingTagsView: View {
    var user: User
    var followingTags: [Tag]
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag.circle")
                    .foregroundColor(Color(UIColor(hex: "FB8C00")))
                Text(user.name + "さんがフォローしているタグ")
                    .bold()
                Spacer()
            }
            .padding()
            HStack {
                if followingTags.count > 0 {
                    FlexibleView(
                        availableWidth: screen.width * 4 / 5, data: followingTags,
                        spacing: 15,
                        alignment: .leading
                      ) { item in
                        TagView(id: item.id, name: item.name)
                      }
                    Spacer()
                } else {
                    Text("まだフォローしていません。")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}
