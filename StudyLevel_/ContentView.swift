//
//  ContentView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    @EnvironmentObject var levelUpViewModel: LevelUpViewModel
    
    var body: some View {
        if CurrentUser().isLogin() {
            if viewModel.error {
                Text(viewModel.errorMessage)
                Text("再起動してください。")
            } else {
                LevelUpView(isShowing: $levelUpViewModel.isShowing, level: levelUpViewModel.level) {
                    MenuView(contentViewModel: viewModel)
                        .onAppear {
                            let timer = Timer.scheduledTimer(
                                timeInterval: 60,
                                target: viewModel,
                                selector: #selector(viewModel.getNotices),
                                userInfo: nil,
                                repeats: true)
                            timer.fire()
                            viewModel.getPrevWeeklyTarget()
                        }
                        .navigationBarHidden(true)
                }
            }
        } else {
            SignupOrLoginView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
