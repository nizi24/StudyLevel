//
//  NotificationItemView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/20.
//

import SwiftUI

struct NotificationItemView: View {
    var notice: Notice
    @State var error = false
    @State var errorMessage = ""
    var viewModel = NotificationViewModel()
    
    init(notice: Notice) {
        self.notice = notice
        self.notice.actionUser.avatarURL = notice.actionUser.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
    }
    
    var body: some View {
        HStack {
            NavigationLink(destination: UserPageView(id: notice.actionUserId, error: $error, errorMessage: $errorMessage)) {
                if let urlString = notice.actionUser.avatarURL {
                    if let url = URL(string: urlString) {
                        AvaterView(container: ImageContainer(from: url, userId: notice.actionUserId),
                                   size: 30)
                    } else {
                        DefaultAvatarView(size: 30)
                    }
                } else {
                    DefaultAvatarView(size: 30)
                }
            }
            VStack {
                VStack {
                    if notice.noticeableType == "Like" {
                        if notice.likeType == "TimeReport" {
                            NavigationLink(destination: TimeReportDetailView(viewModel: TimeReportDetailViewModel(timeReportId: notice.timeReportId!), error: $error, errorMessage: $errorMessage)) {
                                Text("@\(notice.screenName)さんがあなたの学習記録をいいねしました。")
                            }
                        } else if notice.likeType == "Comment" {
                            NavigationLink(destination: TimeReportDetailView(viewModel: TimeReportDetailViewModel(timeReportId: notice.timeReportId!), error: $error, errorMessage: $errorMessage)) {
                                Text("@\(notice.screenName)さんがあなたのコメントをいいねしました。")
                            }
                        }
                    } else if notice.noticeableType == "Comment" {
                        NavigationLink(destination: TimeReportDetailView(viewModel: TimeReportDetailViewModel(timeReportId: notice.timeReportId!), error: $error, errorMessage: $errorMessage)) {
                            Text("@\(notice.screenName)さんがあなたの学習記録にコメントしました。")
                        }
                    } else if notice.noticeableType == "Relationship" {
                        NavigationLink(destination: UserPageView(id: notice.actionUserId, error: $error, errorMessage: $errorMessage)) {
                            Text("@\(notice.screenName)さんがあなたをフォローしました。")
                        }
                    }
                }
                .foregroundColor(.primary)
                HStack {
                    Text(viewModel.processingCreatedAt(createdAt: notice.createdAt))
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(3)
                    Spacer()
                }
            }
            Spacer()
        }
    }
}
