//
//  WeeklyTargetTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/22.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension WeeklyTarget {
    static var exampleJSON: String {
        """
        {"id":8,"user_id":2,"start_date":"2020-11-16T00:00:00.000+09:00","end_date":"2020-11-22T23:59:59.999+09:00",
        "achieve":false,"created_at":"2020-11-22T16:17:27.437+09:00","updated_at":"2020-11-22T16:17:27.437+09:00",
        "checked":false,"target_time":"2000-01-01T03:00:00.000+09:00","progress":"2000-01-01T00:01:00.000+09:00"}
        """
    }
}

class WeeklyTargetTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = WeeklyTarget.exampleJSON.data(using: .utf8)!
        let weeklyTarget = try jsonDecoder.decode(WeeklyTarget.self, from: data)
        XCTAssertEqual(weeklyTarget.userId, 2)
        XCTAssertEqual(weeklyTarget.startDate, "2020-11-16T00:00:00.000+09:00")
        XCTAssertEqual(weeklyTarget.achieve, false)
    }
}
