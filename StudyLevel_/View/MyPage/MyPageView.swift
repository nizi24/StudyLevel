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
    @State var isFirst = true
        
    var body: some View {
        NavigationView {
            ZStack {
                Color.backgroundGray
                    .edgesIgnoringSafeArea(.all)
                LoadingView(title: $title, isShowing: $viewModel.connecting) {
                    ScrollView(.vertical) {
                        VStack {
                            ProfileView(viewModel: viewModel)
                                .frame(height: 250)
                                .background(Color.white)
                                .padding()
                            ExperienceProgressView(viewModel: viewModel)
                                .frame(height: 100)
                                .padding()
                                .background(Color.white)
                            WeeklyTargetView(viewModel: viewModel)
                                .frame(height: 100)
                                .padding()
                                .background(Color.white)
                            Spacer()
                            VStack {
                                if let timeReports = viewModel.timeReports {
                                    ForEach(timeReports, id: \.self) { timeReport in
                                        TimeReportView(viewModel: TimeReportViewModel(timeReport: timeReport, creator: viewModel.user, isFirst: isFirst),
                                                       connecting: $viewModel.connecting)
                                            .background(Color.white)
                                    }
                                }
                            }
                        }
                    }
                    .frame(width: screen.width * 19 / 20)
                }.alert(isPresented: $viewModel.error) {
                    Alert(title: Text("エラー"), message: Text(viewModel.errorMessage), dismissButton: .cancel())
                }
                .navigationBarTitle(Text("マイページ"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        viewModel.getToServer()
                    }, label: { Image(systemName: "goforward") }))
            }
        }
        .onAppear {
            if viewModel.getToRealm() {
                isFirst = false
            } else {
                isFirst = true
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
