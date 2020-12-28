//
//  WeeklyTargetListItem.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import SwiftUI

struct WeeklyTargetListItem: View {
    @StateObject var viewModel: WeeklyTargetListItemViewModel
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    init(weeklyTarget: WeeklyTarget) {
        _viewModel = StateObject(wrappedValue: WeeklyTargetListItemViewModel(weeklyTarget: weeklyTarget))
    }
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom) {
                Image(systemName: "calendar")
                    .padding(.leading, 20)
                    .padding(.top, 10)
                Text(viewModel.processingWeekly())
                    .font(.callout)
                Spacer()
            }
            .foregroundColor(.secondary)
            HStack(alignment: .bottom) {
                HStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("目標")
                                .bold()
                            Spacer()
                        }
                        EmphasizeTimeView(sfSymbolName: "target", dateTimeString: $viewModel.weeklyTarget.targetTime)
                    }
                    Spacer()
                }.frame(width: screen.width * 1 / 2)
                HStack {
                    VStack {
                        HStack {
                            Spacer()
                            Text("報告時間")
                                .bold()
                            Spacer()
                        }
                        EmphasizeTimeView(sfSymbolName: "clock", dateTimeString: $viewModel.weeklyTarget.progress)
                    }
                    Spacer()
                }.frame(width: screen.width * 1 / 2)
                Spacer()
            }
            .padding(.top, 10)
            .onAppear {
                viewModel.getExperieceRecord()
            }
            if let experienceRecord = viewModel.experienceRecord {
                Text("目標達成！")
                    .foregroundColor(Color(UIColor(hex: "FF6F00")))
                    .font(.title)
                    .padding(.vertical, 10)
                HStack(alignment: .bottom) {
                    Spacer()
                    Image(systemName: "arrow.turn.right.up")
                    Text("ボーナスEXP")
                        .font(.caption)
                    Text(String(experienceRecord.experiencePoint))
                        .font(.largeTitle)
                        .bold()
                        .offset(y: 7)
                        .foregroundColor(Color(UIColor(hex: "FF6F00")))
                    Text("EXP")
                        .font(.caption)
                        .foregroundColor(Color.black)
                    Spacer()
                }
            }
        }
    }
}
