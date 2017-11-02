//
//  ExcersiceTest.swift
//  WabbitduckTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbitduck

class ExcersiceTests: XCTestCase {
    let exercise = Exercise(times: 2, warmup: 1)
    
    func testRunExercise() {
        let result = exercise.run("sleep") { sleep(1) }
        XCTAssertEqual("sleep", result.name)
        XCTAssertEqual(1, Int(result.time))
    }
}
