//
//  OBJsonParseTests.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/7/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class OBJsonParseTests: XCTestCase {
    var source : Data = {
        let filepath = Bundle.main.path(forResource: "countries", ofType: "json")!
        let str = try! String(contentsOfFile: filepath)
        return str.data(using: .utf8)!
    }()
    lazy var shared = OBJsonParse.shared() as! OBJsonParse
    
    func testDecode() {
        let result = shared.parseAllCountries(from:source)!
        let lastCountry = result.last! as! OBCountry
        XCTAssertEqual(246, result.count)
        XCTAssertEqual("ZW", lastCountry.iso)
        XCTAssertEqual("Zimbabwe", lastCountry.name)
        XCTAssertEqual(15, lastCountry.languages.count)
    }
}

