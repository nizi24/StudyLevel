//
//  SearchTagListItem.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct SearchTagListItem: View {
    var i: Int
    var tag: SearchTag
    @State var error = false
    @State var errorMessage = ""
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        NavigationLink(destination: TagPageView(tagId: tag.id)) {
            HStack {
                HStack {
                    if i == 0 {
                        TagView(id: tag.id, name: tag.name)
                            .padding(.leading, 3)
                            .padding(.trailing, 10)
                    } else {
                        TagView(id: tag.id, name: tag.name)
                            .padding(.trailing, 10)
                    }
                    Spacer()
                }
                .frame(width: screen.width * 2 / 5)
                HStack {
                    Text("フォロワー：")
                        .font(.caption)
                        .padding(.trailing, 5)
                    Text(String(tag.followerCount))
                        .bold()
                        .padding(5)
                }
                .foregroundColor(.primary)
                HStack {
                    Text("投稿数：")
                        .font(.caption)
                        .padding(.trailing, 5)
                    Text(String(tag.timeReportCount))
                        .bold()
                        .padding(5)
                }
                .foregroundColor(.primary)
            }
        }
    }
}
