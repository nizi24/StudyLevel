//
//  TagPageView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import SwiftUI

struct TagPageView: View {
    var tagId: Int
    @ObservedObject var viewModel: TagPageViewModel
    @State var reload = false
    @State var title = "通信中・・・"
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    init(tagId: Int) {
        self.tagId = tagId
        _viewModel = ObservedObject(initialValue: TagPageViewModel(tagId: tagId))
    }
    
    var body: some View {
        ZStack {
            Color.backgroundGray
                .edgesIgnoringSafeArea(.all)
            LoadingView(title: $title, isShowing: $viewModel.connecting) {
                VStack {
                    TagProfileView(viewModel: viewModel)
                        .background(Color.white)
                        .padding()
                        .frame(width: screen.width * 19 / 20)
                    TimeReportsView(error: $viewModel.error, errorMessage: $viewModel.errorMessage, viewModel: viewModel, reload: $reload)
                }
            }
            .navigationBarTitle(Text(viewModel.tagPage.name))
        }
        .onChange(of: reload) { reload in
            if reload {
                viewModel.getTagPage()
                self.reload = false
            }
        }
        .onAppear {
            viewModel.getTagPage()
        }
    }
}

struct TagPageView_Previews: PreviewProvider {
    static var previews: some View {
        TagPageView(tagId: 1)
    }
}
