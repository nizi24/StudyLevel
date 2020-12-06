//
//  FeedViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/06.
//

import Foundation

class FeedViewModel: ObservableObject {
    @Published var feedType: FeedType = .timeline
    
    enum FeedType: String, CaseIterable {
        case timeline = "タイムライン"
        case tagFeed = "タグフィード"
        case newest = "新着順"
    }
}
