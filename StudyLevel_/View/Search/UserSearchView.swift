//
//  UserSearchView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct UserSearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var word = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("ユーザーを検索", text: $word)
            }
            .onChange(of: word) { word in
                if !word.isEmpty {
                    viewModel.searchUser(word: word)
                } else {
                    viewModel.users = []
                }
            }
            .padding()
            Divider()
            Spacer()
            ScrollView(.vertical) {
                if let users = viewModel.users {
                    ForEach(users.indices, id: \.self) { i in
                        SearchUserListItem(user: users[i])
                        Divider()
                    }
                }
            }
        }
    }
}
