//
//  SearchViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/12.
//

import Foundation

class SearchViewModel: ObservableObject {
    @Published var searchType: SearchType = .user
    @Published var word = ""
    @Published var users: [SearchUser]?
    @Published var tags: [SearchTag]?
    @Published var timeReports: [TimeReport]?
    
    func searchUser(word: String) {
        let request = SearchUserRequest().search(word: word)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                }
            case .failure(_): break
            }
        }
    }
    
    func searchTag(name: String) {
        let request = TagSearchRequest().search(name: name)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let tags):
                DispatchQueue.main.async {
                    self?.tags = tags
                }
            case .failure(_): break
            }
        }
    }
    
    func searchTimeReport(tagName: String) {
        let request = TimeReportsRequest().search(tagName: tagName)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
                }
            case .failure(_): break
            }
        }
    }
    
    func getTimeReportMore(tagName: String) {
        let request = TimeReportsRequest().search(tagName: tagName, offset: timeReports?.count ?? 0)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports?.append(contentsOf: timeReports)
                }
            case .failure(_): break
            }
        }
    }

    
    func levelColor(user: SearchUser) -> String {
        if user.experience.level >= 100 {
            return "FF6F00"
        } else if user.experience.level >= 80 {
            return "FF8F00"
        } else if user.experience.level >= 50 {
            return "FFA000"
        } else if user.experience.level >= 20 {
            return "FFCA28"
        } else {
            return "FFD54F"
        }
    }
    
    enum SearchType: String, CaseIterable {
        case user = "ユーザー"
        case tag = "タグ"
        case timeReport = "学習時間"
    }
}
