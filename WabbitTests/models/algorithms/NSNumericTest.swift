//
//  NSNumericTest.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class NSNumericTests: XCTestCase {
    lazy var shared = NSNumeric.shared()!

    func testFactorial() {
        XCTAssertEqual(6, shared.factorialLong(3))
        XCTAssertEqual(3628800, shared.factorialLong(10))
        XCTAssertEqual(479001600, shared.factorialLong(12))
    }

    func testPrime() {
        XCTAssertFalse(shared.isPrimeLong(1))
        XCTAssertTrue(shared.isPrimeLong(3))
        XCTAssertFalse(shared.isPrimeLong(4))
        XCTAssertFalse(shared.isPrimeLong(10))
        XCTAssertTrue(shared.isPrimeLong(29))
        XCTAssertTrue(shared.isPrimeLong(181))
        XCTAssertTrue(shared.isPrimeLong(2017))
        XCTAssertTrue(shared.isPrimeLong(64019))
        XCTAssertTrue(shared.isPrimeLong(104729))
    }

    func testPrimePerformance() {
        self.measure {
            shared.isPrimeLong(104729)
        }
    }
}
