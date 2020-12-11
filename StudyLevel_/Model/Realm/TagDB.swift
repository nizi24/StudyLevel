//
//  TagDB.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import RealmSwift

class TagDB: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var createdAt: String = ""
    @objc dynamic var updatedAt: String = ""
    
    func create(tag: Tag) -> Self {
        id = tag.id
        name = tag.name
        createdAt = tag.createdAt
        updatedAt = tag.updatedAt
        return self
    }
}
