//
//  MyPageView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct MyPageView: View {
    @ObservedObject var viewModel = MyPageViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.user?.name ?? "")
            ExperienceProgressView(viewModel: MyPageViewModel())
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
