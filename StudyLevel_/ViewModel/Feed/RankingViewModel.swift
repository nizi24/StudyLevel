//
//  RankingViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation

class RankingViewModel: ObservableObject {
    @Published var users: [RankingUser]?
    @Published var term: Term = .weekly
    @Published var connecting = false
    
    func getExperienceRank() {
        connecting = true
        let request = RankingRequest().experience_rank()
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                    self?.connecting = false
                }
            case .failure(_): break
            }
        }
    }
    
    func getExperienceRankWeekly() {
        connecting = true
        let request = RankingRequest().experience_rank(weekly: true)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                    self?.connecting = false
                }
            case .failure(_): break
            }
        }
    }
    
    func getExperienceRankMonthly() {
        connecting = true
        let request = RankingRequest().experience_rank(monthly: true)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch (result) {
            case .success(let users):
                DispatchQueue.main.async {
                    self?.users = users
                    self?.connecting = false
                }
            case .failure(_): break
            }
        }
    }
    
    enum Term: String, CaseIterable {
        case weekly = "週間"
        case monthly = "月間"
        case all = "全て"
    }
}
