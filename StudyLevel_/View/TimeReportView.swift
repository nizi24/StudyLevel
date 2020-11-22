//
//  TimeReportView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import SwiftUI

struct TimeReportView: View {
    @ObservedObject var viewModel: TimeReportViewModel
    @State var screen: CGSize = UIScreen.main.bounds.size
    @Binding var connecting: Bool
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    if let url = viewModel.avatarURL {
                        AvaterView(container: ImageContainer(from: url),
                                   size: 30)
                    } else {
                        DefaultAvatarView(size: 30)
                    }
                }
                .padding()
                .padding(.leading, 20)
                VStack {
                    HStack {
                        Text(viewModel.creator?.name ?? "")
                            .foregroundColor(.primary)
                            .font(.callout)
                            .bold()
                        Spacer()
                    }
                    HStack {
                        Text("@" + (viewModel.creator?.screenName ?? ""))
                            .foregroundColor(.secondary)
                            .font(.caption)
                        Spacer()
                    }
                }
                Spacer()
            }
            HStack {
                Image(systemName: "calendar")
                    .padding(.leading)
                Text(viewModel.processingStudyDate())
                    .font(.footnote)
                Spacer()
            }
            .padding(.leading, 20)
            if let tags = viewModel.tags {
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
                    Text(viewModel.processingStudyHour())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(UIColor(hex: viewModel.changeColor())))
                        .offset(y: 7)
                    Text("時間")
                        .font(.caption)
                    Text(viewModel.processingStudyMinute())
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(UIColor(hex: viewModel.changeColor())))
                        .offset(y: 7)
                    Text("分")
                        .font(.caption)
                }
                .frame(width: screen.width * 1 / 2)
                HStack(alignment: .bottom) {
                    Image(systemName: "arrow.turn.right.up")
                    Text(String(viewModel.experienceRecord?.experiencePoint ?? 0))
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(UIColor(hex: viewModel.changeColor())))
                        .offset(y: 7)
                    Text("EXP")
                        .font(.caption)
                }
                .frame(width: screen.width * 1 / 2)
            }
            .padding(.top, 5)
            if !viewModel.timeReport.memo.isEmpty {
                Text(viewModel.timeReport.memo)
                    .padding(.top, 15)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
            }
            HStack {
                Image(systemName: "ellipsis.bubble")
                Spacer()
                Image(systemName: "heart")
            }
            .padding(.top, 15)
            .padding(.leading, 35)
            .padding(.trailing, 30)
            .padding(.bottom, 15)
            Divider()
            Spacer()
        }
    }
    
    private func generateTags() -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero
    
        return ZStack(alignment: .topLeading) {
            if let tagList = viewModel.tags {
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

struct TimeReportView_Previews: PreviewProvider {
    static var previews: some View {
        TimeReportView(viewModel: TimeReportViewModel(timeReport: TimeReport(id: 1, userId: 1, studyTime: "2000-01-01T23:01:00.000+09:00", studyDate: "2020-11-21T18:41:00.000+09:00", memo: "勉強した", createdAt: "2020-11-21T11:19:55.927+09:00")), connecting: .constant(false))
    }
}
