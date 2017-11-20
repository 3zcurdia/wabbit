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
    var source: Data = {
        let filepath = Bundle.main.path(forResource: "countries", ofType: "json")!
        return (try! String(contentsOfFile: filepath)).data(using: .utf8)!
    }()
    lazy var nsshared = NSJsonParse.shared()!

    func testDecode() {
        let result = JsonParse.shared.decodeAllCountries(data: source)
        let lastCountry = result.last!
        XCTAssertEqual(148, result.count)
        XCTAssertEqual("MA", lastCountry.iso)
        XCTAssertEqual("Morocco", lastCountry.name)
        XCTAssertEqual(2, lastCountry.languages.count)
    }

    func testEncode() {
        let result = JsonParse.shared.encodeAllCountries(JsonParse.shared.defaultDecoded)
        XCTAssertEqual(50, result.lengthOfBytes(using: .utf8))
    }

    func testEncodeObjc() {
        var objcSource = [NSDictionary]()
        for item in JsonParse.shared.defaultDecoded {
            objcSource.append(NSCountry(iso: item.iso, name: item.name, languanges: item.languages).dictionary()! as NSDictionary)
        }
        let result = nsshared.encodeAllCountries(from: objcSource)!
        XCTAssertEqual(90, result.lengthOfBytes(using: .utf8))
    }

    func testDecodeObjc() {
        let result = nsshared.decodeAllCountries(from: source)!
        let lastCountry = result.last! as! NSCountry
        XCTAssertEqual(148, result.count)
        XCTAssertEqual("MA", lastCountry.iso)
        XCTAssertEqual("Morocco", lastCountry.name)
        XCTAssertEqual(2, lastCountry.languages.count)
    }
}
