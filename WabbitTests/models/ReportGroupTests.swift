//
//  ReportGroupTests.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/4/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

import XCTest
@testable import Wabbit

class ReportGroupTests: XCTestCase {
    
    func testBuild() {
        let reportGroup = ReportGroup.build("X", objcMethod: {
            let x = 1+1
        }, swiftMethod: {
            let y = 1/1
        })
        XCTAssertEqual("X", reportGroup.title)
        XCTAssertEqual(1.0, reportGroup.objcReport.baselineComparison())
        XCTAssertEqual(2.0, reportGroup.objcReport.baselineComparison())
    }
}
