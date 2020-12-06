//
//  CommentForm.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import SwiftUI

struct CommentFormView: View {
    var timeReportId: Int
    @ObservedObject var viewModel: CommentFormViewModel
    @Binding var reload: Bool
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
            Divider()
        }
        .alert(isPresented: $viewModel.aleat) {
            switch(viewModel.aleatType) {
            case .createSuccess:
                return Alert(title: Text("完了"), message: Text("コメントを投稿しました。"), dismissButton: .default(Text("OK"), action: {
                    reload = true
                }))
            case .error:
                return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
            case .none:
                return Alert(title: Text("エラー"))
            }
        }
    }
}

struct CommentForm_Previews: PreviewProvider {
    static var previews: some View {
        CommentFormView(timeReportId: 0, viewModel: CommentFormViewModel(), reload: .constant(true))
    }
}
