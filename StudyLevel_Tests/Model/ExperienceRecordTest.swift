//
//  ExperienceRecordTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension ExperienceRecord {
    static var exampleJSON: String {
        """
        {"id":10,"user_id":2,"experience_point":1381,"time_report_id":10,"bonus_multiplier":1.0}
        """
    }
}

class ExperienceRecordTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = ExperienceRecord.exampleJSON.data(using: .utf8)!
        let experienceRecord = try jsonDecoder.decode(ExperienceRecord.self, from: data)
        XCTAssertEqual(experienceRecord.id, 10)
        XCTAssertEqual(experienceRecord.experiencePoint, 1381)
        XCTAssertEqual(experienceRecord.userId, 2)
    }
}

