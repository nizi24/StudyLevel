//
//  FollowingDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/11.
//

import Foundation
import RealmSwift

class FollowingDB: Object {
    @objc dynamic var followingId: Int = 0
    
    func create(followingId: Int) -> Self {
        self.followingId = followingId
        return self
    }
}
