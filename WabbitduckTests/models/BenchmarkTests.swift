//
//  WabbitduckTests.swift
//  WabbitduckTests
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbitduck

class WabbitduckTests: XCTestCase {
    let report1 = Report(name: "Method A", time: 0.2)
    let report2 = Report(name: "Method B", time: 0.4)
    let report3 = Report(name: "Method C", time: 0.8)
    
    func testCompareIncomplete() {
        XCTAssertNil(Benchmark(reports: nil).compare())
        XCTAssertNil(Benchmark(reports: [report1]).compare())
    }
    
    func testCompare() {
        let bm = Benchmark(reports: [report2, report1, report3])
        let comparison = bm.compare()
        XCTAssertNotNil(comparison)
        XCTAssertEqual(1.0, comparison!["Method A"]!)
        XCTAssertEqual(2.0, comparison!["Method B"]!)
        XCTAssertEqual(4.0, comparison!["Method C"]!)
    }

    func testCompareAppendResult() {
        var bm = Benchmark(reports: [report2])
        bm.reports?.append(report3)
        let comparison = bm.compare()
        XCTAssertNotNil(comparison)
        XCTAssertEqual(1.0, comparison!["Method B"]!)
        XCTAssertEqual(2.0, comparison!["Method C"]!)
    }
    
//    func testPerformanceExample() {
//        self.measure {
//        }
//    }
}
