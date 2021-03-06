//
//  MyPageViewModel.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation

class UserPageViewModel: ObservableObject {
    var id: Int
    @Published var error = false
    @Published var errorMessage = ""
    @Published var user: User? = nil
    @Published var experience: Experience? = nil
    @Published var requiredEXP: RequiredEXP? = nil
    @Published var followingCount: Int = 0
    @Published var followerCount: Int = 0
    @Published var isFollowing: Bool = false
    @Published var weeklyTarget: WeeklyTarget?
    @Published var timeReports: [TimeReport]?
    @Published var connecting: Bool
    
    init(id: Int) {
        self.id = id
        connecting = false
    }
        
    func getToServer() {
        connecting = true
        getUser()
        getExperience()
        getFollowingCount()
        getFollowerCount()
        getIsFollowing()
        getTimeReports()
        getWeeklyTarget()
    }
    
    private func getUser() {
        let request = UserRequest().show(id: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let user):
                // メインスレッドから投稿しないと警告が出る & Viewの再構築が遅くなる
                DispatchQueue.main.async {
                    self?.user = user
                    self?.user?.avatarURL = user.avatarURL?.replacingOccurrences(of: "localhost", with: "192.168.11.10")
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getExperience() {
        let request = ExperienceRequest().show(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let experience):
                DispatchQueue.main.async {
                    self?.experience = experience
                    self?.getRequiredEXP()
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getRequiredEXP() {
        guard let level = experience?.level else {
            error = true
            errorMessage = "通信に失敗しました"
            self.connecting = false
            return
        }
        let request = RequiredEXPRequest().show(level: level)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let requiredEXP):
                DispatchQueue.main.async {
                    self?.requiredEXP = requiredEXP
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getFollowingCount() {
        let request = FollowCountRequest().followingCount(id: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let followingCount):
                DispatchQueue.main.async {
                    self?.followingCount = followingCount
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getFollowerCount() {
        let request = FollowCountRequest().followerCount(id: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let followerCount):
                DispatchQueue.main.async {
                    self?.followerCount = followerCount
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getIsFollowing() {
        guard let userId = CurrentUser().currentUser()?.id else {
            return
        }
        let request = IsFollowingRequest().is_following(targetUserId: id, currentUserId: userId)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let isFollowing):
                DispatchQueue.main.async {
                    self?.isFollowing = isFollowing
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    private func getWeeklyTarget() {
        let request = WeeklyTargetRequest().show(userId: id)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let weeklyTarget):
                DispatchQueue.main.async {
                    self?.weeklyTarget = weeklyTarget
                }
            case .failure(_): break
            }
        }
    }
    
    private func getTimeReports() {
        let timeReportsCount = timeReports?.count ?? 30
        let request = TimeReportsRequest().index(userId: id, limit: timeReportsCount >= 30 ? timeReportsCount : 30)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports = timeReports
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    func getTimeReportMore() {
        connecting = true
        let request = TimeReportsRequest().index(userId: id, offset: timeReports?.count ?? 0)
        StudyLevelClient().send(request: request) { [weak self] result in
            switch result {
            case .success(let timeReports):
                DispatchQueue.main.async {
                    self?.timeReports?.append(contentsOf: timeReports)
                    self?.connecting = false
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self?.connecting = false
                    self?.error = true
                    self?.errorMessage = "通信に失敗しました。"
                }
            }
        }
    }
    
    func block() {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            return
        }
        let request = BlockRequest().create(currentUserId: currentUserId, userId: id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let blockedId):
                BlockDB().create(blockedUserId: blockedId)
            case .failure(_): break
            }
        }
    }
    
    func unblock() {
        guard let currentUserId = CurrentUser().currentUser()?.id else {
            return
        }
        let request = BlockRequest().delete(currentUserId: currentUserId, userId: id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let blockedId):
                BlockDB().delete(blockedUserId: blockedId)
            case .failure(_): break
            }
        }

    }
    
    func progress() -> Double? {
        guard let experienceToNext = experience?.experienceToNext, let requiredEXP = requiredEXP?.requiredEXP else {
            return nil
        }
        let proportion: Double = 100 - Double(experienceToNext) / Double(requiredEXP) * 100
        if isMaxLevel() { return 100 }
        return proportion == 100 ? 0 : proportion
    }
    
    func progressNumeretor() -> String {
        guard let experienceToNext = experience?.experienceToNext, let requiredEXP = requiredEXP?.requiredEXP else {
            return ""
        }
        if isMaxLevel() { return "MAX" }
        return "\(requiredEXP - experienceToNext)/\(requiredEXP)"
    }
    
    func isMaxLevel() -> Bool {
        guard let requiredEXP = requiredEXP?.requiredEXP else {
            return false
        }
        return requiredEXP == 1660
    }
    
    func weeklyTargetProgress() -> Double {
        guard let target = weeklyTarget else {
            return 0
        }
        let progressMinutes = conversionDateTimeToMinute(dateTime: target.progress)
        let targetMinutes = conversionDateTimeToMinute(dateTime: target.targetTime)
        return Double(progressMinutes) / Double(targetMinutes) * 100
    }
    
    func weeklyTargetProgressNumeretor() -> String {
        guard let target = weeklyTarget else {
            return ""
        }
        let progressDateArray = conversionDateTimeToArray(dateTime: target.progress)
        let targetTimeDateArray = conversionDateTimeToArray(dateTime: target.targetTime)
        let progressHour = (Int(progressDateArray[0])! - 1) * 24 + Int(progressDateArray[1])!
        let targetTimeHour = (Int(targetTimeDateArray[0])! - 1) * 24 + Int(targetTimeDateArray[1])!
        return "\(progressHour):\(progressDateArray[2])/\(targetTimeHour):\(targetTimeDateArray[2])"
    }
    
    func processingWeeklyStart() -> String {
        guard let target = weeklyTarget else {
            return ""
        }
        let pattern = "^\\d{4}-0?(\\d{1,2})-(\\d{2})"
        let weeklyStartArray = target.startDate.capture(pattern: pattern, group: [1, 2])
        let weeklyEndArray = target.endDate.capture(pattern: pattern, group: [1, 2])
        return "\(weeklyStartArray[0])月\(weeklyStartArray[1])日〜\(weeklyEndArray[0])月\(weeklyEndArray[1])日"
    }
    
    private func conversionDateTimeToMinute(dateTime: String) -> Int {
        let dateArray = conversionDateTimeToArray(dateTime: dateTime)
        let calcMinutes = ((Int(dateArray[0])! - 1) * 24 * 60) + (Int(dateArray[1])! * 60) + Int(dateArray[2])!
        return calcMinutes
    }
    
    private func conversionDateTimeToArray(dateTime: String) -> [String] {
        let splitToArray = dateTime.split(separator: "T")
        let day = splitToArray[0].split(separator: "-")[2]
        let time = splitToArray[1].split(separator: ":")
        let hour = time[0]
        let minutes = time[1]
        return [String(day), String(hour), String(minutes)]
    }
    
    func levelColor() -> String {
        guard let level = experience?.level else {
           return "FFD54F"
        }
        if level >= 100 {
        return "FF6F00"
      } else if level >= 80 {
        return "FF8F00"
      } else if level >= 50 {
        return "FFA000"
      } else if level >= 20 {
        return "FFCA28"
      } else {
        return "FFD54F"
      }
    }
}
