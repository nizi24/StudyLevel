//
//  WeeklyTargetView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import SwiftUI

struct WeeklyTargetView: View {
    @ObservedObject var viewModel: MyPageViewModel
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "target")
                Text("今週の目標")
                Spacer()
            }
            ProgressView(value: viewModel.weeklyTargetProgress(), total: 100)
                .scaleEffect(y: 3)
        }
    }
}

struct WeeklyTargetView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTargetView(viewModel: MyPageViewModel())
    }
}
