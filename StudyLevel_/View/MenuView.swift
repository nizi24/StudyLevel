//
//  MenuView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel = MenuViewModel()
    
    var body: some View {
        ZStack {
            NavigationLink(
                destination: ContentView(),
                isActive: $viewModel.isNotLogin,
                label: {
                    EmptyView()
                })
            TabView {
                Button(action: {
                    viewModel.logout()
                }, label: {
                    Text("Logout")
                })
                    .tabItem { Text("Home") }
                Text("Create")
                    .tabItem { Text("Create") }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MenuView()
        }
    }
}
