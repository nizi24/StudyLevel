//
//  MyPageView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel = MyPageViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var title = "通信中・・・"
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                ScrollView(.vertical) {
                    VStack {
                        ProfileView(viewModel: MyPageViewModel())
                            .frame(height: 250)
                            .background(Color.white)
                            .padding()
                        ExperienceProgressView(viewModel: MyPageViewModel())
                            .frame(height: 100)
                            .padding()
                            .background(Color.white)
                        Spacer()
                        VStack {
                            if let timeReports = viewModel.timeReports {
                                ForEach(timeReports, id: \.self) { timeReport in
                                    TimeReportView(viewModel: TimeReportViewModel(timeReport: timeReport, creator: viewModel.user), connecting: $viewModel.connecting)
                                        .background(Color.white)
                                }
                            }
                        }
                    }
                }
                .frame(width: screen.width * 19 / 20)
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
