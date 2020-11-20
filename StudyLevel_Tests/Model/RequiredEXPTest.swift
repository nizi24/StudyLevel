//
//  UserTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/17.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension RequiredEXP {
    static var exampleJSON: String {
        """
            {
                "level":1,
                "total_experience":50,
                "required_exp":50
            }
        """
    }
}

class RequiredEXPTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = RequiredEXP.exampleJSON.data(using: .utf8)!
        let requiredEXP = try jsonDecoder.decode(RequiredEXP.self, from: data)
        XCTAssertEqual(requiredEXP.requiredEXP, 50)
        XCTAssertEqual(requiredEXP.totalExperience, 50)
        XCTAssertEqual(requiredEXP.level, 1)
    }
}
