//
//  DeviceRequest.swift
//  StudyLevel_
//
//  Created by Yuu Nishida on 2020/12/19.
//

import Foundation

class DeviceRequest: Request {
    var path: String = "/v2/devices"
    var method: HTTPMethod = .post
    var queryItems: [URLQueryItem]?
    var body: Encodable?
    var contentType: String?
    typealias Response = Device
    
    func create(userId: Int, token: String) -> Self {
        let params = ["user_id": userId, "token": token] as [String : Any]
        do {
            body = try JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        } catch {
            fatalError()
        }
        return self
    }
}
