//
//  WeeklyTargetView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import SwiftUI

struct WeeklyTargetView: View {
    @ObservedObject var viewModel: UserPageViewModel
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "target")
                    .padding(.leading, 5)
                Text("今週の目標")
                Text(viewModel.processingWeeklyStart())
                Spacer()
            }
            if viewModel.weeklyTarget != nil {
                HStack {
                    ProgressView(value: viewModel.weeklyTargetProgress(), total: 100)
                        .scaleEffect(y: 3)
                    Text(viewModel.weeklyTargetProgressNumeretor())
                        .foregroundColor(.secondary)
                        .font(.footnote)
                }
                .frame(width: screen.width * 9 / 10)
            } else {
                HStack {
                    if let currentUserId = CurrentUser().currentUser()?.id, currentUserId == viewModel.user?.id {
                        NavigationLink(destination: WeeklyTargetFormView()) {
                            Text("目標を設定する")
                                .font(.caption)
                                .padding()
                        }
                    } else {
                        Text("まだ目標を設定していません。")
                            .font(.caption)
                            .padding()
                    }
                    Spacer()
                }
            }
        }
    }
}

struct WeeklyTargetView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTargetView(viewModel: UserPageViewModel(id: 1))
    }
}
