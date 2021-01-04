//
//  TimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import SwiftUI

struct TimeReportView: View {
    @StateObject var viewModel = TimeReportViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var editFormAppear = false
    @State var changeLikesCount: Int = -1
    @Binding var reload: Bool
    var timeReport: TimeReport
    @Binding var editReload: Bool
    @ObservedObject var likesCount: LikesCount
    var currentPageUserId: Int?

    init(timeReport: TimeReport, reload: Binding<Bool>, currentPageUserId: Int?) {
        self.timeReport = timeReport
        _reload = reload
        _editReload = .constant(false)
        self.currentPageUserId = currentPageUserId
        likesCount = LikesCount(likesCount: timeReport.likesCount)
        changeLikesCount = -1
        self.timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
    }
    
    init(timeReport: TimeReport, reload: Binding<Bool>, currentPageUserId: Int?, editReload: Binding<Bool>) {
        self.timeReport = timeReport
        _reload = reload
        _editReload = editReload
        self.currentPageUserId = currentPageUserId
        likesCount = LikesCount(likesCount: timeReport.likesCount)
        changeLikesCount = -1
        self.timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
    }
    
    var body: some View {
        if !BlockDB().find(userId: timeReport.userId) {
            NavigationLink(destination: TimeReportDetailView(viewModel: TimeReportDetailViewModel(timeReport: timeReport, timeReportId: timeReport.id, likesCount: likesCount.likesCount), error: $viewModel.aleat, errorMessage: $viewModel.errorMessage)) {
                VStack {
                    HStack {
                        VStack {
                            if let urlString = timeReport.creator.avatarURL {
                                if let url = URL(string: urlString) {
                                    AvaterView(container: ImageContainer(from: url, userId: timeReport.creator.id),
                                               size: 30)
                                } else {
                                    DefaultAvatarView(size: 30)
                                }
                            } else {
                                DefaultAvatarView(size: 30)
                            }
                        }
                        .padding()
                        .padding(.leading, 20)
                        if currentPageUserId == nil {
                            NavigationLink(destination: UserPageView(id: timeReport.userId, error: $viewModel.aleat, errorMessage: $viewModel.errorMessage)) {
                                VStack {
                                    HStack {
                                        Text(timeReport.creator.name)
                                            .foregroundColor(.primary)
                                            .font(.callout)
                                            .bold()
                                        Spacer()
                                    }
                                    HStack {
                                        Text("@" + (timeReport.creator.screenName))
                                            .foregroundColor(.secondary)
                                            .font(.caption)
                                        Spacer()
                                    }
                                }
                            }
                        } else if let currentPageUserId = currentPageUserId, currentPageUserId != timeReport.userId {
                            NavigationLink(destination: UserPageView(id: timeReport.userId, error: $viewModel.aleat, errorMessage: $viewModel.errorMessage)) {
                                VStack {
                                    HStack {
                                        Text(timeReport.creator.name)
                                            .foregroundColor(.primary)
                                            .font(.callout)
                                            .bold()
                                        Spacer()
                                    }
                                    HStack {
                                        Text("@" + (timeReport.creator.screenName))
                                            .foregroundColor(.secondary)
                                            .font(.caption)
                                        Spacer()
                                    }
                                }
                            }
                        } else {
                            VStack {
                                HStack {
                                    Text(timeReport.creator.name)
                                        .foregroundColor(.primary)
                                        .font(.callout)
                                        .bold()
                                    Spacer()
                                }
                                HStack {
                                    Text("@" + (timeReport.creator.screenName))
                                        .foregroundColor(.secondary)
                                        .font(.caption)
                                    Spacer()
                                }
                            }
                        }
                        Spacer()
                        if viewModel.displayEditButton(creatorId: timeReport.creator.id) {
                            NavigationLink(destination: EditTimeReportView(timeReportFormViewModel: TimeReportFormViewModel(timeReport: timeReport), reload: $editReload)) {
                                Image(systemName: "square.and.pencil")
                            }
                            .padding(.trailing, 20)
                            Button(action: {
                                viewModel.confirmDelete()
                            }, label: {
                                Image(systemName: "trash")
                            })
                            .padding(.trailing, 30)
                        }
                    }
                    HStack {
                        Image(systemName: "calendar")
                            .padding(.leading)
                        Text(viewModel.processingStudyDate(timeReport: timeReport))
                            .font(.footnote)
                        Spacer()
                    }
                    .foregroundColor(Color.black)
                    .padding(.leading, 20)
                    if let tags = timeReport.tags {
                        if !tags.isEmpty {
                            HStack {
                                FlexibleView(
                                    availableWidth: 330, data: tags,
                                    spacing: 15,
                                    alignment: .leading
                                  ) { item in
                                    TagView(id: item.id, name: item.name)
                                  }
                                Spacer()
                            }
                            .padding(.top, 15)
                            .padding(.leading, 35)
                        }
                    }
                    HStack(alignment: .bottom) {
                        HStack(alignment: .bottom) {
                            Image(systemName: "clock")
                                .padding(.leading, 10)
                                .foregroundColor(Color.black)
                            Text(viewModel.processingStudyHour(timeReport: timeReport))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(UIColor(hex: viewModel.changeColor(timeReport: timeReport))))
                                .offset(y: 7)
                            Text("時間")
                                .font(.caption)
                                .foregroundColor(Color.black)
                            Text(viewModel.processingStudyMinute(timeReport: timeReport))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(UIColor(hex: viewModel.changeColor(timeReport: timeReport))))
                                .offset(y: 7)
                            Text("分")
                                .font(.caption)
                                .foregroundColor(Color.black)
                        }
                        .frame(width: screen.width * 1 / 2)
                        HStack(alignment: .bottom) {
                            Image(systemName: "arrow.turn.right.up")
                                .foregroundColor(Color.black)
                            Text(String(timeReport.experienceRecord.experiencePoint))
                                .font(.largeTitle)
                                .bold()
                                .foregroundColor(Color(UIColor(hex: viewModel.changeColor(timeReport: timeReport))))
                                .offset(y: 7)
                            Text("EXP")
                                .font(.caption)
                                .foregroundColor(Color.black)
                        }
                        .frame(width: screen.width * 1 / 2)
                    }
                    .padding(.top, 5)
                    if !timeReport.memo.isEmpty {
                        HStack {
                            Text(timeReport.memo)
                                .padding(.top, 15)
                                .padding(.leading, 50)
                                .padding(.trailing, 30)
                                .foregroundColor(Color.black)
                                .fixedSize(horizontal: false, vertical: true)
                            Spacer()
                        }
                    }
                    HStack {
                        Image(systemName: "ellipsis.bubble")
                            .foregroundColor(Color.black)
                        Text(String(timeReport.commentsCount))
                            .foregroundColor(Color.black)
                            .font(.caption)
                        Spacer()
                        TimeReportLikeButtonView(timeReport: timeReport, count: $changeLikesCount)
                        Text(String(likesCount.likesCount))
                            .foregroundColor(Color.black)
                            .font(.caption)
                    }
                    .padding(.top, 15)
                    .padding(.leading, 35)
                    .padding(.trailing, 30)
                    .padding(.bottom, 15)
                    Divider()
                    Text("")
                }
                .alert(isPresented: $viewModel.aleat, content: {
                    switch (viewModel.aleatType) {
                    case .deleteSuccess:
                        return Alert(title: Text("完了"),
                        message: Text("記録を削除しました。"),
                        dismissButton: .default(Text("OK"), action: {
                            reload = true
                        }))
                    case .error:
                        return Alert(title: Text("エラー"),
                                     message: Text(viewModel.errorMessage))
                    case .confirmDelete:
                        return Alert(title: Text("確認"), message: Text("削除しますか？\n（削除した場合、レベルが下がる恐れがあります。）"),
                                                                      primaryButton: .destructive(Text("削除"), action: {
                                                                        viewModel.delete(timeReportId: timeReport.id)
                                                                      }), secondaryButton: .cancel(Text("キャンセル")))
                    }
                })
                .onChange(of: changeLikesCount) { changeLikesCount in
                    if changeLikesCount == 0 {
                        likesCount.likesCount -= 1
                        self.changeLikesCount = -1
                    } else if changeLikesCount == 1 {
                        likesCount.likesCount += 1
                        self.changeLikesCount = -1
                    }
                }
            }
        }
    }        
}

class LikesCount: ObservableObject {
    @Published var likesCount: Int
    
    init(likesCount: Int) {
        self.likesCount = likesCount
    }
}
