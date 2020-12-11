//
//  TimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import SwiftUI

struct TimeReportViewNonNavigationLink: View {
    @StateObject var viewModel: TimeReportViewModel = TimeReportViewModel()
    @State var screen: CGSize = UIScreen.main.bounds.size
    @State var editFormAppear = false
    var timeReport: TimeReport {
        didSet {
            timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
            likesCount = timeReport.likesCount
        }
    }
    @State var changeLikesCount: Int = -1
    @State var likesCount = 0
    
    init(timeReport: TimeReport) {
        self.timeReport = timeReport
        self.timeReport.creator.avatarURL = timeReport.creator.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
        _likesCount = State(initialValue: timeReport.likesCount)
    }
    
    var body: some View {
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
                Spacer()
                if viewModel.displayEditButton(creatorId: timeReport.creator.id) {
                    NavigationLink(
                        destination: EditTimeReportView(timeReportFormViewModel: TimeReportFormViewModel(timeReport: timeReport))
                    ) {
                        Image(systemName: "square.and.pencil")
                    }
                    .padding(.trailing, 20)
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
                            TagView(name: item.name)
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
                Text(timeReport.memo)
                    .padding(.top, 15)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .foregroundColor(Color.black)
            }
            HStack {
                Image(systemName: "ellipsis.bubble")
                    .foregroundColor(Color.black)
                Text(String(timeReport.commentsCount))
                    .foregroundColor(Color.black)
                    .font(.caption)
                Spacer()
                TimeReportLikeButtonView(timeReport: timeReport, count: $changeLikesCount)
                Text(String(likesCount))
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
                default:
                    return Alert(title: Text("エラー"),
                                 message: Text(viewModel.errorMessage))
            }
        })
        .onChange(of: changeLikesCount) { changeLikesCount in
            if changeLikesCount == 0 {
                likesCount -= 1
                self.changeLikesCount = -1
            } else if changeLikesCount == 1 {
                likesCount += 1
                self.changeLikesCount = -1
            }
        }
    }
        
    private func generateTags() -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
    
        return ZStack(alignment: .topLeading) {
            if let tagList = timeReport.tags {
                ForEach(tagList, id: \.self) { tag in
                    TagView(name: tag.name)
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
