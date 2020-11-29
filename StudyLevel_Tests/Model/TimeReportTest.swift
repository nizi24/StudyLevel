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
        {"id":148,"user_id":2,"study_time":"2000-01-02T00:01:00.000+09:00","memo":"","created_at":"2020-11-29T20:19:04.958+09:00","updated_at":"2020-11-29T20:19:04.958+09:00","study_date":"2020-11-29T20:18:41.000+09:00","likes_count":0,"comments_count":0,"experience_record":{"id":148,"user_id":2,"time_report_id":148,"experience_point":1,"bonus_multiplier":1.0,"created_at":"2020-11-29T20:19:04.981+09:00","updated_at":"2020-11-29T20:19:04.981+09:00"},"tags":[],"user":{"id":2,"name":"てすと","screen_name":"QGFYYjmCZNU4","created_at":"2020-11-19T12:46:02.207+09:00","updated_at":"2020-11-19T12:46:02.207+09:00","profile":null,"guest":false,"avatar_url":null}}
        """
    }
}

class TimeReportTest: XCTestCase {
    func testDecode() throws {
        let jsonDecoder = JSONDecoder()
        let data = TimeReport.exampleJSON.data(using: .utf8)!
        let timeReport = try jsonDecoder.decode(TimeReport.self, from: data)
        XCTAssertEqual(timeReport.id, 148)
        XCTAssertEqual(timeReport.studyTime, "2000-01-02T00:01:00.000+09:00")
        XCTAssertEqual(timeReport.userId, 2)
    }
}
