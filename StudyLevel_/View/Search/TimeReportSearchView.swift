//
//  TimeReportSearchView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct TimeReportSearchView: View {
    @StateObject var viewModel: SearchViewModel
    @State var word = ""
    @State var reload = false
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("学習記録をタグで検索", text: $word)
            }
            .onChange(of: word) { word in
                if !word.isEmpty {
                    viewModel.searchTimeReport(tagName: word)
                } else {
                    viewModel.timeReports = []
                }
            }
            .padding()
            Divider()
            Spacer()
            ScrollView(.vertical) {
                if let timeReports = viewModel.timeReports {
                    ForEach(timeReports.indices, id: \.self) { i in
                        TimeReportView(timeReport: timeReports[i], reload: $reload, currentPageUserId: nil)
                    }
                }
                if let timeReports = viewModel.timeReports {
                    if !timeReports.isEmpty && timeReports.count % 30 == 0 {
                        Button(action: {
                            viewModel.getTimeReportMore(tagName: word)
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
            }
            .frame(width: screen.width * 19 / 20)
            .onChange(of: reload) { reload in
                if reload {
                    viewModel.searchTimeReport(tagName: word)
                    self.reload = false
                }
            }
        }
        .onAppear {
            if !word.isEmpty {
                viewModel.searchTimeReport(tagName: word)
            }
        }
    }
}
