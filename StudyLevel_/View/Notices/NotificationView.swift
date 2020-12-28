//
//  NotificationView.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import SwiftUI

struct NotificationView: View {
    @ObservedObject var contentViewModel: ContentViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical) {
                if contentViewModel.notices.isEmpty {
                    Text("通知はまだありません。")
                        .padding()
                } else {
                    ForEach(contentViewModel.notices.indices, id: \.self) { i in
                        NotificationItemView(notice: contentViewModel.notices[i])
                            .padding()
                        Divider()
                    }
                }
                if !contentViewModel.notices.isEmpty && contentViewModel.notices.count % 30 == 0 {
                    Button(action: {
                        contentViewModel.getNoticesMore()
                    }, label: {
                        Text("もっと見る")
                                .fontWeight(.semibold)
                                .padding()
                                .frame(width: 160, height: 48)
                                .foregroundColor(Color(.blue))
                                .background(Color(.white))
                                .cornerRadius(24)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 24)
                                        .stroke(Color(.blue), lineWidth: 1.0)
                                )
                    })
                }
                Spacer()
            }
            .navigationBarTitle(Text("通知"), displayMode: .inline)
            .navigationBarItems(trailing: NavigationLink(destination: WeeklyTargetHistoryView(contentViewModel: contentViewModel)) {
                Image(systemName: contentViewModel.prevWeeklyTargetCheck ? "calendar" : "calendar.badge.exclamationmark")
                    .foregroundColor(contentViewModel.prevWeeklyTargetCheck ? .blue : .orange)
                }.onTapGesture {
                    contentViewModel.prevWeeklyTargetCheck = true
                }
            )
            .onAppear {
                contentViewModel.noticesCheck()
            }
        }
    }
}
