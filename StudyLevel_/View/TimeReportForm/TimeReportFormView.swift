//
//  CreateTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI
import PartialSheet

struct TimeReportFormView: View {
    @ObservedObject var viewModel: TimeReportFormViewModel
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    private static let placeholder = "メモ・学習内容"
    @State private var placeholderText = placeholder
    @ObservedObject var keyboardObserver = KeyboardObserver()
    @State var screen: CGSize = UIScreen.main.bounds.size
    
    init(viewModel: TimeReportFormViewModel, keybord: KeyboardObserver) {
        self.viewModel = viewModel
        self.keyboardObserver = keybord
    }
    
    var body: some View {
        ZStack {
            VStack {
                Form {
                    Button(action: {
                        self.partialSheetManager.showPartialSheet(content: {
                            VStack {
                                DatePicker(selection: $viewModel.studyDate,
                                           in: viewModel.oneWeekBefore()...Date(),
                                           label: {})
                                    .datePickerStyle(WheelDatePickerStyle())
                                    .labelsHidden()
                            }
                        })
                    }, label: {
                        HStack {
                            Image(systemName: "calendar")
                            Text("学習日時")
                            Text(viewModel.processingStudyDate())
                                .foregroundColor(.primary)
                        }
                    })
                    Button(action: {
                        self.partialSheetManager.showPartialSheet(content: {
                            HStack {
                                Picker(selection: $viewModel.studyHour, label: Text("")) {
                                    ForEach(0...23, id: \.self) { i in
                                        Text("\(i)時間")
                                    }
                                }.frame(width: 150)
                                .clipped()
                                Picker(selection: $viewModel.studyMinute, label: Text("")) {
                                    ForEach(0...59, id: \.self) { i in
                                        Text("\(i)分")
                                    }
                                }.frame(width: 150)
                                .clipped()
                            }
                        })
                    }, label: {
                        HStack {
                            Image(systemName: "clock")
                            Text("学習時間")
                            Text("\(viewModel.studyHour)時間 \(viewModel.studyMinute)分")
                                .foregroundColor(.primary)
                        }
                    })
                    HStack {
                        TextField("タグ", text: $viewModel.tagName)
                            .padding()
                        Button(action: {
                            viewModel.addTag()
                        }, label: {
                            Image(systemName: "plus")
                        })
                        .frame(width: 30)
                    }
                    if viewModel.tags.isEmpty {
                        Text("タグ一覧")
                            .foregroundColor(Color.secondary)
                            .padding()
                    } else {
                        ScrollView(.horizontal) {
                            HStack {
                                FlexibleView(
                                    availableWidth: 330, data: viewModel.tags,
                                    spacing: 15,
                                    alignment: .leading
                                  ) { item in
                                    TagView(name: item, showX: true, timeReportFormViewModel: viewModel)
                                  }
                                Spacer()
                            }
                        }
                    }
                    ZStack {
                        TextEditor(text: $viewModel.memo)
                            .onTapGesture {
                                if !viewModel.memo.isEmpty {
                                    placeholderText = ""
                                }
                            }
                            .onChange(of: viewModel.memo) { value in
                                if viewModel.memo.isEmpty {
                                    placeholderText = Self.placeholder
                                } else {
                                    placeholderText = ""
                                }
                            }
                        if viewModel.memo.isEmpty {
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
                                if viewModel.memo.count <= 280 {
                                    Text(String(viewModel.memo.count) + "/280")
                                        .font(.caption)
                                        .foregroundColor(Color.secondary)
                                } else {
                                    Text(String(viewModel.memo.count) + "/280")
                                        .font(.caption)
                                        .foregroundColor(Color.red)
                                }
                            }
                        }
                    }
                    .frame(height: 300)
                    if !viewModel.errorMessage.isEmpty {
                        Text(viewModel.errorMessage)
                            .foregroundColor(Color.red)
                    }
                }
                if !keyboardObserver.isShowing {
                    AdView(unitID: "ca-app-pub-2760885204397772/7075287463")
                        .frame(maxWidth: .infinity)
                        .frame(height: 40)
                }
            }.addPartialSheet()
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
    
    private func generateTags() -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
    
        return ZStack(alignment: .topLeading) {
            if let tagList = viewModel.tags {
                ForEach(tagList, id: \.self) { tag in
                    TagView(name: tag)
                        .padding([.horizontal, .vertical], 4)
                        .alignmentGuide(.leading, computeValue: { d in
                            if abs(width - d.width) > 330 {
                                width = 0
                                height -= d.height
                            }
                            let result = width
                            if tag == tagList.last {
                                width = 0
                            } else {
                                width -= d.width
                            }
                            return result
                        })
                        .alignmentGuide(.top, computeValue: { _ in
                            let result = height
                            if tag == tagList.last {
                                height = 0
                            }
                            return result
                        })
                    }
                }
            }
        }
}

struct TimeReportFormView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TimeReportFormView(viewModel: TimeReportFormViewModel(), keybord: KeyboardObserver())
        }
    }
}
