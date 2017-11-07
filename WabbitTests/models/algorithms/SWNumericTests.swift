//
//  SWNumeric.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class SWNumericTests: XCTestCase {
    
    func testFactorial(){
        XCTAssertEqual(6, SWNumeric.shared.factorial(int: 3))
        XCTAssertEqual(3628800, SWNumeric.shared.factorial(int: 10))
        XCTAssertEqual(479001600, SWNumeric.shared.factorial(int: 12))
    }
    
    func testPrime() {
        XCTAssertFalse(SWNumeric.shared.isPrime(int: 1))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 3))
        XCTAssertFalse(SWNumeric.shared.isPrime(int: 4))
        XCTAssertFalse(SWNumeric.shared.isPrime(int: 10))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 29))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 181))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 2017))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 64019))
        XCTAssertTrue(SWNumeric.shared.isPrime(int: 104729))
    }
    
    func testPrimePerformance() {
        self.measure {
            _ = SWNumeric.shared.isPrime(int: 104729)
        }
    }
}