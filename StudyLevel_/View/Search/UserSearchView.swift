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
                viewModel.searchUser(word: word)
            }
            .padding()
            Divider()
            Spacer()
            ScrollView(.vertical) {
                if let users = viewModel.users {
                    ForEach(users.indices, id: \.self) { i in
                        SearchUserListItem(viewModel: viewModel, user: users[i])
                        Divider()
                    }
                }
            }
        }
    }
}
