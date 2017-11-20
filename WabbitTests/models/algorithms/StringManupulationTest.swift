//
//  StringManupulationTest.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/15/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import Foundation

import XCTest
@testable import Wabbit

class StringManipulationTests: XCTestCase {
    let text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr."

    func testReplace() {
        let expected = "L0r3m 1p5um d0l0r 517 4m37, c0n53737ur 54d1p5c1n9 3l17r."
        XCTAssertEqual(expected, StringManipulation.shared.textWithNumbers(text))
        XCTAssertEqual(expected, NSStringManipulation.shared().textWithNumbers(for: text))
    }

    func testMatch() {
        let expected = ["ip", "it", "ip", "in", "it"]
        XCTAssertEqual(expected, StringManipulation.shared.matches(for: "i\\D", in: text))
        XCTAssertEqual(expected, NSStringManipulation.shared().matches(for: "i\\D", in: text))
    }

    func testConcat() {
        let expected = "lorem/ipsum"
        XCTAssertEqual(expected, StringManipulation.shared.append(string: "lorem", to: "ipsum"))
        XCTAssertEqual(expected, NSStringManipulation.shared().append("lorem", to: "ipsum")!)
    }
}
