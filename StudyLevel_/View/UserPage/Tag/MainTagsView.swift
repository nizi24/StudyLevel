//
//  MainTagsView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/14.
//

import SwiftUI
    
struct MainTagsView: View {
    var user: User
    var mainTags: [MainTag]
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "tag.circle")
                    .foregroundColor(Color(UIColor(hex: "FB8C00")))
                Text(user.name + "さんがよく使用しているタグ")
                    .bold()
                Spacer()
            }
            .padding()
            HStack {
                if mainTags.count > 0 {
                    FlexibleView(
                        availableWidth: screen.width * 4 / 5, data: mainTags,
                        spacing: 15,
                        alignment: .leading
                      ) { item in
                        TagView(id: item.id, name: item.name)
                      }
                    Spacer()
                } else {
                    Text("まだタグを使用していません。")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .padding()
        }
    }
}
