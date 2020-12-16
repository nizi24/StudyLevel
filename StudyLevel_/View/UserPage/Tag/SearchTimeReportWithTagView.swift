//
//  SearchTimeReportWithTagView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/15.
//

import SwiftUI

struct SearchTimeReportWithTagView: View {
    var user: User
    @State var searchWord = ""
    @StateObject var viewModel = SearchTimeReportWithTagViewModel()
    @State var reload = false
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("タグで\(user.name)さんの学習記録を検索", text: $searchWord)
            }
            .onChange(of: searchWord) { word in
                if !word.isEmpty {
                    viewModel.searchTimeReportWithTagName(userId: user.id, tagName: word)
                } else {
                    viewModel.timeReports = []
                }
            }
            .padding()
            Spacer()
            if let timeReports = viewModel.timeReports {
                ForEach(timeReports.indices, id: \.self) { i in
                    TimeReportView(timeReport: timeReports[i], reload: $reload, currentPageUserId: nil)
                }
            }
            if let timeReports = viewModel.timeReports {
                if !timeReports.isEmpty && timeReports.count % 30 == 0 {
                    Button(action: {
                        viewModel.searchTimeReportWithTagNameGetMore(userId: user.id, tagName: searchWord)
                    }, label: {
                        Text("もっと見る")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 160, height: 48)
                                .foregroundColor(Color(.blue))
                                .background(Color(.white))
                                .cornerRadius(24)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(.blue), lineWidth: 1.0)
                                )
                    })
                }
            }
            Spacer()
            .onChange(of: reload) { reload in
                if reload {
                    viewModel.searchTimeReportWithTagName(userId: user.id, tagName: searchWord)
                    self.reload = false
                }
            }
        }
        .onAppear {
            if !searchWord.isEmpty {
                viewModel.searchTimeReportWithTagName(userId: user.id, tagName: searchWord)
            }
        }
    }
}
