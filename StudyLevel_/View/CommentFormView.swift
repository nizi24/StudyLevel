//
//  CommentForm.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct CommentFormView: View {
    var timeReportId: Int
    @ObservedObject var viewModel = CommentFormViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    var body: some View {
        VStack {
            HStack {
                Text("コメント")
                    .bold()
                    .padding(.leading)
                Spacer()
            }
            ZStack {
                TextEditor(text: $viewModel.content)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        if viewModel.content.count <= 280 {
                            Text(String(viewModel.content.count) + "/280")
                                .font(.caption)
                                .foregroundColor(Color.secondary)
                        } else {
                            Text(String(viewModel.content.count) + "/280")
                                .font(.caption)
                                .foregroundColor(Color.red)
                        }
                    }
                }
                .padding()
            }
            .frame(width: screen.width * 19 / 20, height: 150)
            .border(Color.secondary)
            HStack {
                Spacer()
                Button(action: {
                    viewModel.createComment(timeReportId: timeReportId)
                }, label: {
                    Text("送信")
                })
            }.padding(.trailing, 30)
            .padding(.top)
        }
    }
}

struct CommentForm_Previews: PreviewProvider {
    static var previews: some View {
        CommentFormView(timeReportId: 1)
    }
}
