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
    @State var reload = false
        
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
                                    ForEach(timeReports.indices, id: \.self) { i in
                                        TimeReportView(timeReport: timeReports[i], reload: $reload)
                                            .background(Color.white)
                                    }
                                }
                            }
                            if let timeReports = viewModel.timeReports {
                                if !timeReports.isEmpty && timeReports.count % 30 == 0 {
                                    Button(action: {
                                        viewModel.getTimeReportMore()
                                    }, label: {
                                        Text("もっと見る")
                                                .fontWeight(.semibold)
                                                .padding()
                                                .frame(width: 160, height: 48)
                                                .foregroundColor(Color(.blue))
                                                .background(Color(.white))
                                                .cornerRadius(24)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 24)
                                                        .stroke(Color(.blue), lineWidth: 1.0)
                                                )
                                    })
                                }
                            }
                            Spacer()
                        }
                    }
                    .frame(width: screen.width * 19 / 20)
                }
                .navigationBarTitle(Text("マイページ"), displayMode: .inline)
                .navigationBarItems(trailing: Button(action: {
                        viewModel.getToServer()
                    }, label: { Image(systemName: "goforward") }))
            }
            .onAppear {
                viewModel.getToServer()
            }
            .onChange(of: reload) { reload in
                if reload {
                    viewModel.getToServer()
                    self.reload = false
                }
            }
        }
        .alert(isPresented: $viewModel.error) {
            Alert(title: Text("エラー"), message: Text(viewModel.errorMessage), dismissButton: .cancel())
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
