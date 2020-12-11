//
//  UserTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension User {
    static var exampleJSON: String {
        """
        {
            "id":1,
            "name":"guest",
            "screen_name":"guest",
            "created_at":"2020-08-14T19:01:19.343+09:00",
            "updated_at":"2020-08-31T18:18:43.835+09:00",
            "profile":"ゲストアカウントです。",
            "guest":true
        }
        """
    }
}

class UserTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = User.exampleJSON.data(using: .utf8)!
        let user = try jsonDecoder.decode(User.self, from: data)
        XCTAssertEqual(user.id, 1)
        XCTAssertEqual(user.createdAt, "2020-08-14T19:01:19.343+09:00")
        XCTAssertEqual(user.name, "guest")
        XCTAssertEqual(user.guest, true)
    }
}
