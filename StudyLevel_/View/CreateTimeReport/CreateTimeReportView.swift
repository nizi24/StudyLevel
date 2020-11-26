//
//  CreateTimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI
import PartialSheet

struct CreateTimeReportView: View {
    @ObservedObject var viewModel = CreateTimeReportViewModel()
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    private static let placeholder = "aa"
    @State private var placeholderText = placeholder
    
    var body: some View {
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
                ZStack {
                    TextEditor(text: $viewModel.memo)
                        .onTapGesture {
                            if viewModel.memo.isEmpty {
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
                    Text(placeholderText)
                        .padding()
                        .foregroundColor(.gray)
                }
            }
        }.addPartialSheet()
    }
}

struct CreateTimeReportView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CreateTimeReportView()
        }
    }
}
