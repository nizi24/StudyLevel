//
//  EmphasizeTimeView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/21.
//

import SwiftUI

struct EmphasizeTimeView: View {
    var sfSymbolName: String
    @Binding var dateTimeString: String
    var viewModel = EmphasizeTimeViewModel()
    
    var body: some View {
        HStack(alignment: .bottom) {
            Image(systemName: sfSymbolName)
                .padding(.leading, 10)
                .foregroundColor(Color.black)
            Text(viewModel.processingHour(dateTimeString: dateTimeString))
                .font(.largeTitle)
                .bold()
                .offset(y: 7)
                .foregroundColor(Color(UIColor(hex: viewModel.timeColor(dateTimeString: dateTimeString))))
            Text("時間")
                .font(.caption)
                .foregroundColor(Color.black)
            Text(viewModel.processingMinute(dateTimeString: dateTimeString))
                .font(.largeTitle)
                .bold()
                .offset(y: 7)
                .foregroundColor(Color(UIColor(hex: viewModel.timeColor(dateTimeString: dateTimeString))))
            Text("分")
                .font(.caption)
                .foregroundColor(Color.black)
        }
    }
}
