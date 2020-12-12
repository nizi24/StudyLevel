//
//  SearchView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel = SearchViewModel()
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        ZStack {
            VStack {
                Picker(selection: $viewModel.searchType, label: Text("")) {
                    ForEach(SearchViewModel.SearchType.allCases, id: \.self) { mode in
                        Text(mode.rawValue).tag(mode)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                Spacer()
                if viewModel.searchType == .user {
                    UserSearchView(viewModel: viewModel)
                } else if viewModel.searchType == .tag {
                    TagSearchView(viewModel: viewModel)
                }// else if viewModel.searchType == .timeReport {
    //
    //            }
            }
            .onAppear {
                keyboardObserver.addObserver()
            }
            .onDisappear {
                keyboardObserver.removeObserver()
            }
            .navigationBarTitle(Text("検索"))
            if keyboardObserver.isShowing {
                Button(action: {
                    UIApplication.shared.endEditing()
                }, label: {
                    Text("閉じる")
                        .bold()
                })
                .frame(width: screen.width * 2,height: 50)
                .background(Color(UIColor(hex: "B0BEC5")))
                .position(x: screen.width - 50, y: screen.height - keyboardObserver.height - 115)
            }

        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
