//
//  WeeklyTargetHistoryView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import SwiftUI

struct WeeklyTargetHistoryView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    @StateObject var viewModel = WeeklyTargetHistoryViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ScrollView(.vertical) {
            if let weeklyTargets = viewModel.weeklyTargets {
                ForEach(weeklyTargets.indices, id: \.self) { i in
                    WeeklyTargetListItem(weeklyTarget: weeklyTargets[i])
                    Divider()
                }
                if weeklyTargets.isEmpty {
                    Text("目標の履歴はありません。")
                        .padding()
                }
            }
        }
        .frame(width: screen.width * 19 / 20)
        .onAppear {
            viewModel.getWeeklyTargets()
        }
        .navigationBarTitle(Text("週間目標の履歴"), displayMode: .inline)
    }
}
