//
//  Device.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/19.
//

import Foundation

class Device: Decodable {
    var id: Int
    var userId: Int
    var firebaseRegistrationToken: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case userId = "user_id"
        case firebaseRegistrationToken = "firebase_registration_token"
    }
}
