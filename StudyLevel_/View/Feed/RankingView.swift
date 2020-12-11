//
//  RankingView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct RankingView: View {
    @ObservedObject var viewModel = RankingViewModel()
    @State var error = false
    @State var errorMessage = ""
    
    var body: some View {
        VStack {
            Picker(selection: $viewModel.term, label: Text("ホーム")) {
                ForEach(RankingViewModel.Term.allCases, id: \.self) { mode in
                    Text(mode.rawValue).tag(mode)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            ScrollView(.vertical) {
                if let users = viewModel.users {
                    ForEach(users.indices, id: \.self) { i in
                        RankingUserListItem(rank: i + 1, user: users[i], error: $error, errorMessage: $errorMessage)
                        Divider()
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text("経験値ランキング"))
        .onChange(of: viewModel.term) { term in
            if term == .weekly {
                viewModel.getExperienceRankWeekly()
            } else if term == .monthly {
                viewModel.getExperienceRankMonthly()
            } else if term == .all {
                viewModel.getExperienceRank()
            }
        }
        .onAppear {
            if viewModel.term == .weekly {
                viewModel.getExperienceRankWeekly()
            } else if viewModel.term == .monthly {
                viewModel.getExperienceRankMonthly()
            } else if viewModel.term == .all {
                viewModel.getExperienceRank()
            }
        }
    }
}

struct RankingView_Previews: PreviewProvider {
    static var previews: some View {
        RankingView()
    }
}
