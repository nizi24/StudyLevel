//
//  TimeReportDetailView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct TimeReportDetailView: View {
    var viewModel: TimeReportDetailViewModel
    @State var reload = false
    @State var connecting = false
    
    var body: some View {
        ScrollView(.vertical) {
            TimeReportViewNonNavigationLink(viewModel: TimeReportViewModel(timeReport: viewModel.timeReport),
                                            reload: $reload, connecting: $connecting)
            
        }
    }
}
