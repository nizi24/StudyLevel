//
//  ContentView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/15.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = ContentViewModel()
    
    var body: some View {
        if CurrentUser().isLogin() {
            if viewModel.error {
                Text(viewModel.errorMessage)
            } else {
                MenuView()
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
