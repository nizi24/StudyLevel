//
//  LikeButtonView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import SwiftUI

struct TimeReportLikeButtonView: View {
    @ObservedObject var viewModel =  LikeButtonViewModel()
    var timeReport: TimeReport
    @Binding var count: Int
    
    var body: some View {
        VStack {
            if viewModel.liked(timeReport: timeReport) {
                Button(action: {
                    viewModel.unlike(timeReport: timeReport)
                }) {
                    Image(systemName: "heart.fill")
                        .foregroundColor(Color.red)
                }
            } else {
                Button(action: {
                    viewModel.like(timeReport: timeReport)
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(Color.red)
                }
            }
        }
        .onChange(of: viewModel.i) { i in
            if i == 10 {
                count = 1
            } else if i == -10 {
                count = 0
            }
        }
    }
}
