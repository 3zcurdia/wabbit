//
//  SWJsonParse.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class SWJsonParseTests: XCTestCase {
    var source : String = {
        let filepath = Bundle.main.path(forResource: "countries", ofType: "json")!
        return try! String(contentsOfFile: filepath)
    }()
    
    func testDecode() {
        let result = SWJsonParse.shared.parseAllCountries(string:source)
        let lastCountry = result.last!
        XCTAssertEqual(246, result.count)
        XCTAssertEqual("ZW", lastCountry.iso)
        XCTAssertEqual("Zimbabwe", lastCountry.name)
        XCTAssertEqual(15, lastCountry.languages.count)
    }
}
