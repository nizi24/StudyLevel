//
//  TagView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import SwiftUI

struct TagView: View {
    var name: String
    var showX = false
    var timeReportFormViewModel: TimeReportFormViewModel?
    var id: Int?
    
    init(name: String) {
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init(name: String, showX: Bool, timeReportFormViewModel: TimeReportFormViewModel) {
        self.name = name
        self.showX = showX
        self.timeReportFormViewModel = timeReportFormViewModel
    }
    
    var body: some View {
        if let id = id {
            NavigationLink(destination: TagPageView(tagId: id)) {
                HStack {
                    Image(systemName: "tag.fill")
                        .font(.caption)
                    Text(name)
                        .font(.caption)
                    if showX {
                        Button(action: {
                            timeReportFormViewModel?.removeTag(tagName: name)
                        }, label: {
                            Image(systemName: "xmark")
                        })
                    }
                }
                .padding(6)
                .background(Color(UIColor(hex: "FB8C00")))
                .foregroundColor(Color.white)
                .cornerRadius(5.0)
            }
        } else {
            HStack {
                Image(systemName: "tag.fill")
                    .font(.caption)
                Text(name)
                    .font(.caption)
                if showX {
                    Button(action: {
                        timeReportFormViewModel?.removeTag(tagName: name)
                    }, label: {
                        Image(systemName: "xmark")
                    })
                }
            }
            .padding(6)
            .background(Color(UIColor(hex: "FB8C00")))
            .foregroundColor(Color.white)
            .cornerRadius(5.0)
        }
    }
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
        TagView(id: 1, name: "勉強中")
    }
}
