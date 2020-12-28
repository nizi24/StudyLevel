//
//  CurrentUser.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/19.
//

import Foundation
import RealmSwift
import FirebaseAuth

class CurrentUser: Object {
    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var screenName = ""
    @objc dynamic var level = 0
    @objc dynamic var experience = 0
    @objc dynamic var nextToExperience = 0
    
    
    func set() -> Result<CurrentUser, Error> {
        realmMigration()
        removeCurrentUser()
        let realm = try! Realm()
        if isLogin() {
            let uid = Auth.auth().currentUser!.uid
            let semaphore = DispatchSemaphore(value: 0)
            var results: Result<CurrentUser, Error>?
            StudyLevelClient().send(request: UserRequest().currentUser(uid: uid)) { result in
                switch result {
                case .success(let user):
                    self.id = user.id
                    self.name = user.name
                    self.screenName = user.screenName
                    results = .success(self)
                case .failure(_):
                    results =  .failure(StudyLevelClientError.communicationFailed)
                }
                semaphore.signal()
            }
            semaphore.wait()
            switch results {
            case .success(let user):
                try! realm.write {
                    realm.add(user)
                }
            default: break
            }
            getExperienceToServer()
            return results!
        } else {
            let user = realm.objects(CurrentUser.self)
            try! realm.write {
                realm.delete(user)
            }
            return .failure(CurrentUserError.isNotLogin)
        }
    }
    
    func isLogin() -> Bool {
        if Auth.auth().currentUser != nil {
            return true
        }
        return false
    }
    
    func currentUser() -> Self? {
        if isLogin() {
            let realm = try! Realm()
            let user = realm.objects(CurrentUser.self).first
            id = user!.id
            name = user!.name
            screenName = user!.screenName
            guard let lv = user?.level, let exp = user?.experience, let toNext = user?.nextToExperience else {
                getExperienceToServer()
                return nil
            }
            level = lv
            experience = exp
            nextToExperience = toNext
            return self
        } else {
            return nil
        }
    }
    
    func removeCurrentUser() {
        let realm = try! Realm()
        let presentUser = realm.objects(Self.self)
        try! realm.write {
            realm.delete(presentUser)
        }
    }
    
    func setExperiences(level: Int, exprience: Int, toNext: Int) {
        let realm = try! Realm()
        let user = realm.objects(CurrentUser.self).first
        try! realm.write {
            user?.level = level
            user?.experience = experience
            user?.experience = toNext
        }
    }
    
    private func getExperienceToServer() {
        let request = ExperienceRequest().show(userId: id)
        StudyLevelClient().send(request: request) { result in
            switch result {
            case .success(let experience):
                DispatchQueue.main.async {
                    let realm = try! Realm()
                    let user = realm.objects(CurrentUser.self).first
                    try! realm.write {
                        user?.level = experience.level
                        user?.experience = experience.totalExperience
                        user?.experience = experience.experienceToNext
                    }
                }
            case .failure(_): break
            }
        }
    }
    
    private func setCurrentUserToRealm() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    private func realmMigration() {
        let schemaVersion: UInt64 = 7

        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < schemaVersion) {
        }})
        Realm.Configuration.defaultConfiguration = config
    }
    
    enum CurrentUserError: Error {
        case isNotLogin
    }
}
