//
//  StudyLevelAPIError.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation

struct StudyLevelAPIError: Error, Decodable {
    var errors: [String: [String]]
}
