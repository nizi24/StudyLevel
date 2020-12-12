//
//  TimeReportSearchView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct TimeReportSearchView: View {
    @ObservedObject var viewModel: SearchViewModel
    @State var word = ""
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TimeReportSearchView_Previews: PreviewProvider {
    static var previews: some View {
        TimeReportSearchView()
    }
}
