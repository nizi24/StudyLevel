//
//  FeedView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct FeedView: View {
    @ObservedObject var viewModel = FeedViewModel()
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.feedType, label: Text("ホーム")) {
                ForEach(FeedViewModel.FeedType.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
