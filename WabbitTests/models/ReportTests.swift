//
//  WabbitTests.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class ReportTests: XCTestCase {
    let report1 = Report(name: "Method A", time: 0.2, baseline: nil)
    let report2 = Report(name: "Method B", time: 0.4, baseline: nil)

    func testBaselineTimeIncomplete() {
        XCTAssertEqual(report1.time, [report1].baselineTime())
    }

    func testBaselineTime() {
        let baseline = [report2, report1].baselineTime()
        XCTAssertNotNil(baseline)
        XCTAssertEqual(report1.time, baseline)
        XCTAssertNotEqual(report2.time, baseline)
    }

    func testBaselineComparison() {
        XCTAssertEqual(1.0, report1.baselineComparison())
        let report = Report(name: "Method X", time: 2.0, baseline: 0.5)
        XCTAssertEqual(4.0, report.baselineComparison())
    }
}
