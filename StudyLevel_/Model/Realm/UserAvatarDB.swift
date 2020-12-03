//
//  UserAvatarDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/03.
//

import Foundation
import RealmSwift

class UserAvatarDB: Object {
    @objc dynamic var userId: Int = 0
    @objc dynamic var imageData: Data = Data()
    
    func create(userId: Int, imageData: Data) -> Self {
        self.userId = userId
        self.imageData = imageData
        return self
    }
}
