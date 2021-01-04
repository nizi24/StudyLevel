//
//  BlockDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/28.
//

import Foundation
import RealmSwift

class BlockDB: Object {
    @objc dynamic var blockedUserId = 0
    
    func create(blockedUserId: Int) {
        self.blockedUserId = blockedUserId
        save()
    }
    
    func find(userId: Int) -> Bool {
        let realm = try! Realm()
        if realm.objects(Self.self).filter("blockedUserId == %@", userId).first != nil {
            return true
        } else {
            return false
        }
    }
    
    private func save() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(self)
        }
    }
    
    func delete(blockedUserId: Int) {
        let realm = try! Realm()
        let blockDB = realm.objects(Self.self).filter("blockedUserId == %@", blockedUserId)
        try! realm.write {
            realm.delete(blockDB)
        }
    }

    
    func deleteAll() {
        let realm = try! Realm()
        let likes = realm.objects(LikeDB.self)
        try! realm.write {
            realm.delete(likes)
        }
    }
}
