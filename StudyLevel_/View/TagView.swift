//
//  TagView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import SwiftUI

struct TagView: View {
    var name: String
    
    var body: some View {
        HStack {
            Image(systemName: "tag.fill")
                .font(.caption)
            Text(name)
                .font(.caption)
        }
        .padding(6)
        .background(Color(UIColor(hex: "FB8C00")))
        .foregroundColor(Color.white)
        .cornerRadius(5.0)
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(name: "勉強中")
    }
}
