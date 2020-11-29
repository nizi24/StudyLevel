//
//  Tag.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation

struct Tag: Decodable, Hashable {
    var id: Int
    var name: String
    var createdAt: String
    var updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
    
    init(tagDB: TagDB) {
        id = tagDB.id
        name = tagDB.name
        createdAt = tagDB.createdAt
        updatedAt = tagDB.updatedAt
    }
}
