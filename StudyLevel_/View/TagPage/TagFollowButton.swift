//
//  TagFollowButton.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct TagFollowButton: View {
    @ObservedObject var viewModel = TagFollowButtonViewModel()
    var targetUserId: Int
    @Binding var following: Bool
    @Binding var followerCount: Int
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TagFollowButton_Previews: PreviewProvider {
    static var previews: some View {
        TagFollowButton(targetUserId: 1, following: .constant(true), followerCount: .constant(1))
    }
}
