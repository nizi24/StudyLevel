//
//  ProfileFromView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI

struct ProfileFromView: View {
    @ObservedObject var viewModel: ProfileFormViewModel
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    private static let placeholder = "プロフィール"
    @State private var placeholderText = placeholder
    @State var title = "通信中・・・"
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        LoadingView(title: $title, isShowing: $viewModel.connecting) {
            ZStack {
                Form {
                    Section(header: Text("名前")) {
                        TextField("名前", text: $viewModel.name)
                    }
                    Section(header: Text("ユーザーID")) {
                        TextField("ユーザーID", text: $viewModel.screenName)
                    }
                    Section(header: Text("プロフィール")) {
                        ZStack {
                            TextEditor(text: $viewModel.profile)
                                .onTapGesture {
                                    if !viewModel.profile.isEmpty {
                                        placeholderText = ""
                                    }
                                }
                                .onChange(of: viewModel.profile) { value in
                                    if viewModel.profile.isEmpty {
                                        placeholderText = Self.placeholder
                                    } else {
                                        placeholderText = ""
                                    }
                                }
                            if viewModel.profile.isEmpty {
                                VStack {
                                    HStack {
                                        Text(placeholderText)
                                            .padding()
                                            .foregroundColor(.gray)
                                        Spacer()
                                    }
                                    Spacer()
                                }
                            }
                            VStack {
                                Spacer()
                                HStack {
                                    Spacer()
                                    if viewModel.profile.count <= 160 {
                                        Text(String(viewModel.profile.count) + "/160")
                                            .font(.caption)
                                            .foregroundColor(Color.secondary)
                                    } else {
                                        Text(String(viewModel.profile.count) + "/160")
                                            .font(.caption)
                                            .foregroundColor(Color.red)
                                    }
                                }
                            }
                        }
                        .frame(height: 300)
                    }
                    ForEach(viewModel.validationErrorMessages.indices, id: \.self) { i in
                        Text("・" + viewModel.validationErrorMessages[i])
                            .foregroundColor(.red)
                    }
                }
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
            .navigationBarTitle(Text("プロフィール変更"))
            .navigationBarItems(trailing: Button(action: {
                viewModel.update()
            }, label: {
                Text("変更")
            }))
            .onAppear{
                keyboardObserver.addObserver()
            }.onDisappear {
                keyboardObserver.removeObserver()
            }
            .alert(isPresented: $viewModel.alert) {
                switch viewModel.alertType {
                case .success:
                    return Alert(title: Text("完了"), message: Text("プロフィールを変更しました。"), dismissButton: .default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
                case .error:
                    return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
                }
            }
        }
    }
}

struct ProfileFromView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFromView(viewModel: ProfileFormViewModel(name: "test", screenName: "test", profile: "profile"))
    }
}
