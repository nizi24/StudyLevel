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
            List {
                ForEach(viewModel.timeReports.indices, id: \.self) { i in
                    Text(String(viewModel.timeReports[i].id))
                    Text(String(viewModel.timeReports[i].memo))
                }
            }
        }.onAppear {
            viewModel.getTimeReports()
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
