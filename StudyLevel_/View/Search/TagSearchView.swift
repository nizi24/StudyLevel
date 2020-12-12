//
//  TagSearchView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct TagSearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var word = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("タグを検索", text: $word)
            }
            .onChange(of: word) { word in
                viewModel.searchTag(name: word)
            }
            .padding()
            Divider()
            Spacer()
            ScrollView(.vertical) {
                if let tags = viewModel.tags {
                    ForEach(tags.indices, id: \.self) { i in
                        SearchTagListItem(i: i, tag: tags[i])
                        Divider()
                    }
                }
            }
        }
    }
}
