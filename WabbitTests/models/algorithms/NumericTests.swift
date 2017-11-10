//
//  Numeric.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class NumericTests: XCTestCase {
    lazy var nsshared = NSNumeric.shared()!

    func testFactorial(){
        XCTAssertEqual(6, Numeric.shared.factorial(int: 3))
        XCTAssertEqual(3628800, Numeric.shared.factorial(int: 10))
        XCTAssertEqual(479001600, Numeric.shared.factorial(int: 12))
        
        XCTAssertEqual(6, nsshared.factorialLong(3))
        XCTAssertEqual(3628800, nsshared.factorialLong(10))
        XCTAssertEqual(479001600, nsshared.factorialLong(12))
    }
    
    func testPrime() {
        XCTAssertFalse(Numeric.shared.isPrime(int: 1))
        XCTAssertTrue(Numeric.shared.isPrime(int: 3))
        XCTAssertFalse(Numeric.shared.isPrime(int: 4))
        XCTAssertFalse(Numeric.shared.isPrime(int: 10))
        XCTAssertTrue(Numeric.shared.isPrime(int: 29))
        XCTAssertTrue(Numeric.shared.isPrime(int: 181))
        XCTAssertTrue(Numeric.shared.isPrime(int: 2017))
        XCTAssertTrue(Numeric.shared.isPrime(int: 64019))
        XCTAssertTrue(Numeric.shared.isPrime(int: 104729))
        
        XCTAssertFalse(nsshared.isPrimeLong(1))
        XCTAssertTrue(nsshared.isPrimeLong(3))
        XCTAssertFalse(nsshared.isPrimeLong(4))
        XCTAssertFalse(nsshared.isPrimeLong(10))
        XCTAssertTrue(nsshared.isPrimeLong(29))
        XCTAssertTrue(nsshared.isPrimeLong(181))
        XCTAssertTrue(nsshared.isPrimeLong(2017))
        XCTAssertTrue(nsshared.isPrimeLong(64019))
        XCTAssertTrue(nsshared.isPrimeLong(104729))
    }
    
    func testPrimePerformance() {
        self.measure {
            _ = Numeric.shared.isPrime(int: 104729)
        }
    }
    
    func testPrimePerformanceObjc() {
        self.measure {
            _ = nsshared.isPrimeLong(104729)
        }
    }

}
