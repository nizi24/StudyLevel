//
//  UserTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension Experience {
    static var exampleJSON: String {
        """
        {
            "id":2,
            "user_id":2,
            "total_experience":0,
            "level":1,
            "experience_to_next":50}
        """
    }
}

class ExperienceTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = Experience.exampleJSON.data(using: .utf8)!
        let experience = try jsonDecoder.decode(Experience.self, from: data)
        XCTAssertEqual(experience.userId, 2)
        XCTAssertEqual(experience.totalExperience, 0)
        XCTAssertEqual(experience.level, 1)
    }
}
