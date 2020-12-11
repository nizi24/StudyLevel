//
//  DefaultAvatarView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/20.
//

import SwiftUI

struct DefaultAvatarView: View {
    var size: CGFloat = 150
    
    var body: some View {
        Image("defaultIcon")
            .resizable()
            .scaledToFill()
            .frame(width: size, height: size)
            .cornerRadius(size / 2)
            .overlay(
                RoundedRectangle(cornerRadius: size / 2).stroke(Color.black, lineWidth: 4)
            )
    }
}

struct DefaultAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        DefaultAvatarView()
    }
}
