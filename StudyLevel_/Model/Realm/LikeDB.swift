//
//  LikeDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/05.
//

import Foundation
import RealmSwift

class LikeDB: Object {
    @objc dynamic var likeableType = ""
    @objc dynamic var likeableId = 0
    
    func create(like: Like) -> Self {
        likeableType = like.likeableType
        likeableId = like.likeableId
        return self
    }
    
    func save(likedb: LikeDB) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(likedb)
        }
    }
    
    func createAndSave(like: Like) {
        save(likedb: create(like: like))
    }
    
    func find(timeReport: TimeReport) -> Bool {
        let realm = try! Realm()
        if realm.objects(Self.self).filter("likeableType == 'TimeReport' AND likeableId == %@", timeReport.id).first != nil {
            return true
        } else {
            return false
        }
    }
    
    func find(comment: Comment) -> Bool {
        let realm = try! Realm()
        if realm.objects(Self.self).filter("likeableType == 'Comment' AND likeableId == %@", comment.id).first != nil {
            return true
        } else {
            return false
        }
    }
    
    func delete(likeableType: String, likeableId: Int) {
        let realm = try! Realm()
        let like = realm.objects(LikeDB.self).filter("likeableType == %@ AND likeableId == %@", likeableType, likeableId)
        try! realm.write {
            realm.delete(like)
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
