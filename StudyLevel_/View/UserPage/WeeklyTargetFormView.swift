//
//  WeeklyTargetForm.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import SwiftUI
import PartialSheet

struct WeeklyTargetFormView: View {
    @ObservedObject var viewModel = WeeklyTargetFormViewModel()
    @EnvironmentObject var partialSheetManager: PartialSheetManager
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Button(action: {
                self.partialSheetManager.showPartialSheet(content: {
                    HStack {
                        Picker(selection: $viewModel.targetHour, label: Text("")) {
                            ForEach(0...167, id: \.self) { i in
                                Text("\(i)時間")
                            }
                        }.frame(width: 150)
                        .clipped()
                        Picker(selection: $viewModel.targetMinute, label: Text("")) {
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
                    Text("\(viewModel.targetHour)時間 \(viewModel.targetMinute)分")
                        .foregroundColor(.primary)
                }
            })
            if !viewModel.validationMessage.isEmpty {
                Text(viewModel.validationMessage)
                    .foregroundColor(.red)
            }
        }
        .addPartialSheet()
        .navigationBarTitle(Text("目標を作成"))
        .navigationBarItems(trailing: Button(action: {
            viewModel.create()
        }, label: {
            Text("作成")
        }))
        .alert(isPresented: $viewModel.aleat) {
            switch (viewModel.aleatType) {
            case .success:
                return Alert(title: Text("完了"), message: Text("目標を作成しました。"), dismissButton: .default(Text("OK"), action: {
                    presentationMode.wrappedValue.dismiss()
                }))
            case .error:
                return Alert(title: Text("エラー"), message: Text(viewModel.errorMessage))
            }
        }
    }
}

struct WeeklyTargetForm_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyTargetFormView()
    }
}
