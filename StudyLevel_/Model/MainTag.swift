//
//  MainTag.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/14.
//

import Foundation

struct MainTag: Decodable, Hashable {
    var id: Int
    var name: String
    var count: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case count
    }
}
