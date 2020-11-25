//
//  CreateTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct CreateTimeReportView: View {
    @ObservedObject var viewModel = CreateTimeReportViewModel()
    
    var body: some View {
        VStack {
            Form {
                DatePicker(selection: $viewModel.studyDate,
                           in: viewModel.oneWeekBefore()...Date(),
                           label: {
                    Text("学習日時")
                })
                Button(action: {
                    viewModel.tapStudyTime.toggle()
                }, label: { Text("a") })
                    .sheet(isPresented: $viewModel.tapStudyTime) {
                        
                    }
            }
        }
    }
}

struct CreateTimeReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTimeReportView()
        }
    }
}
