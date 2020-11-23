//
//  WeeklyTargetView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import SwiftUI

struct WeeklyTargetView: View {
    @ObservedObject var viewModel: MyPageViewModel
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
            HStack {
                ProgressView(value: viewModel.weeklyTargetProgress(), total: 100)
                    .scaleEffect(y: 3)
                Text(viewModel.weeklyTargetProgressNumeretor())
                    .foregroundColor(.secondary)
                    .font(.footnote)
            }
            .frame(width: screen.width * 9 / 10)
        }
    }
}

struct WeeklyTargetView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTargetView(viewModel: MyPageViewModel())
    }
}
