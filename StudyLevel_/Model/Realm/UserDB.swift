//
//  UserDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class UserDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var screenName: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""
    @objc dynamic var profile: String? = nil
    @objc dynamic var guest: Bool = false
    @objc dynamic var avatarURL: String?
    @objc dynamic var followingCount: Int = 0
    @objc dynamic var followerCount: Int = 0
    @objc dynamic var experience: ExperienceDB? = ExperienceDB()
    @objc dynamic var requiredEXP: RequiredEXPDB? = RequiredEXPDB()
    @objc dynamic var weeklyTarget: WeeklyTargetDB? = WeeklyTargetDB()
    var timeReports = List<TimeReportDB>()
    
    override static func primaryKey() -> String? {
            return "id"
    }
    
    func create(viewModel: UserPageViewModel) -> Self {
        self.id = viewModel.user!.id
        self.name = viewModel.user!.name
        self.screenName = viewModel.user!.screenName
        self.createdAt = viewModel.user!.createdAt
        self.updatedAt = viewModel.user!.updatedAt
        self.profile = viewModel.user!.profile
        self.guest = viewModel.user!.guest
        self.avatarURL = viewModel.user!.avatarURL
        self.followingCount = viewModel.followingCount!
        self.followerCount = viewModel.followerCount!
        self.experience = ExperienceDB().create(experience: viewModel.experience!)
        self.requiredEXP = RequiredEXPDB().create(requiredEXP: viewModel.requiredEXP!)
        self.weeklyTarget = WeeklyTargetDB().create(weeklyTarget: viewModel.weeklyTarget)
        return self
    }
    
    func save() {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(self)
        }
    }
    
    func getCurrentUser() -> Self? {
        guard let id = CurrentUser().currentUser()?.id else {
            return nil
        }
        let realm = try! Realm()
        let currentUser = realm.objects(UserDB.self).filter("id == %@", id).first
        return currentUser as? Self
    }
    
    func removeCurrentUser() {
        guard let id = CurrentUser().currentUser()?.id else {
            return
        }
        let realm = try! Realm()
        let currentUser = realm.objects(UserDB.self).filter("id == %@", id)
        let experience = realm.objects(ExperienceDB.self).filter("userId == %@", id)
        let weeklyTarget = realm.objects(WeeklyTargetDB.self).filter("userId == %@", id)
        let requiredEXP = realm.objects(RequiredEXPDB.self)
        
        try! realm.write {
            realm.delete(currentUser)
            realm.delete(experience)
            realm.delete(weeklyTarget)
            realm.delete(requiredEXP)
            currentUser.first?.timeReports.removeAll()
        }
    }
    
    func appendTimeReport(timeReport: TimeReportDB) {
        guard let user = getCurrentUser() else {
            return
        }
        let realm = try! Realm()
        try! realm.write {
            user.timeReports.append(timeReport)
        }
    }
}
