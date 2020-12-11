//
//  FeedView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct FeedView: View {
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
            .navigationBarTitle(viewModel.feedType.rawValue, displayMode: .inline)
        }
        .alert(isPresented: $error) {
            Alert(title: Text("エラー"), message: Text(errorMessage))
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
