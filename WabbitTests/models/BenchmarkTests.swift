//
//  ExcersiceTest.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class BenchmarkTests: XCTestCase {
    let benchmark = Benchmark(times: 2, warmup: 1)

    func testBMRun() {
        let result = benchmark.run("sleep") { sleep(1) }
        XCTAssertEqual("sleep", result.name)
        XCTAssertEqual(1, Int(result.time))
    }
}
