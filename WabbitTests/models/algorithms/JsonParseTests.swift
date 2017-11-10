//
//  JsonParse.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/6/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class JsonParseTests: XCTestCase {
    var source : String = {
        let filepath = Bundle.main.path(forResource: "countries", ofType: "json")!
        return try! String(contentsOfFile: filepath)
    }()
    lazy var nsshared = NSJsonParse.shared()!
    
    func testDecode() {
        let result = JsonParse.shared.parseAllCountries(string:source)
        let lastCountry = result.last!
        XCTAssertEqual(246, result.count)
        XCTAssertEqual("ZW", lastCountry.iso)
        XCTAssertEqual("Zimbabwe", lastCountry.name)
        XCTAssertEqual(15, lastCountry.languages.count)
    }
    
    func testDecodeObjc() {
        let result = nsshared.parseAllCountries(from:source.data(using: .utf8)!)!
        let lastCountry = result.last! as! NSCountry
        XCTAssertEqual(246, result.count)
        XCTAssertEqual("ZW", lastCountry.iso)
        XCTAssertEqual("Zimbabwe", lastCountry.name)
        XCTAssertEqual(15, lastCountry.languages.count)
    }
}
