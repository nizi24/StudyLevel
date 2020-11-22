//
//  TimeReportTest.swift
//  StudyLevel_Tests
//
//  Created by Yuu Nishida on 2020/11/21.
//

import Foundation
import XCTest
@testable import StudyLevel_

extension TimeReport {
    static var exampleJSON: String {
        """
        {"id":10,"user_id":2,"study_time":"2000-01-01T23:01:00.000+09:00","study_date":"2020-11-21T18:41:00.000+09:00",
        "memo":"","created_at":"2020-11-21T11:17:05.518+09:00"}
        """
    }
}

class TimeReportTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = TimeReport.exampleJSON.data(using: .utf8)!
        let timeReport = try jsonDecoder.decode(TimeReport.self, from: data)
        XCTAssertEqual(timeReport.id, 10)
        XCTAssertEqual(timeReport.studyTime, "2000-01-01T23:01:00.000+09:00")
        XCTAssertEqual(timeReport.userId, 2)
    }
}
