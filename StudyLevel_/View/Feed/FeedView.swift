//
//  FeedView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct FeedView: View {
    @Binding var isNotLogin: Bool
    @ObservedObject var viewModel = FeedViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var error = false
    @State var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Picker(selection: $viewModel.feedType, label: Text("ホーム")) {
                    ForEach(FeedViewModel.FeedType.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                if viewModel.feedType == .timeline {
                    TimeReportsView(error: $error, errorMessage: $errorMessage, viewModel: TimelineViewModel())
                } else if viewModel.feedType == .tagFeed {
                    TimeReportsView(error: $error, errorMessage: $errorMessage, viewModel: TagFeedViewModel())
                } else if viewModel.feedType == .newest {
                    TimeReportsView(error: $error, errorMessage: $errorMessage, viewModel: NewestTimeReportsViewModel())
                }
            }
            .navigationBarItems(leading: NavigationLink(destination: RankingView()) {
                Image(systemName: "crown")
            }, trailing: NavigationLink(destination: SearchView()) {
                Image(systemName: "magnifyingglass")
            })
            .navigationBarTitle(viewModel.feedType.rawValue, displayMode: .inline)
        }
        .alert(isPresented: $error) {
            if !isNotLogin && !errorMessage.isEmpty {
                return Alert(title: Text("エラー"), message: Text(errorMessage))
            }
            return Alert(title: Text("完了"), message: Text("ログアウトしました。"))
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView(isNotLogin: .constant(false))
    }
}
