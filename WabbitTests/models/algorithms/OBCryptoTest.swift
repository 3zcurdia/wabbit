//
//  OBCryptoTest.swift
//  WabbitTests
//
//  Created by Luis Ezcurdia on 11/2/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest
@testable import Wabbit

class OBCryptoTests: XCTestCase {
    let text = "Lorem ipsum dolor sit amet, consetetur sadipscing elitr."
    lazy var shared = OBCrypto.shared() as! OBCrypto

    func testSha1() {
        let expected = "2a0c0bfa51f7aed4c9ea6ecc2650a26d1b4af17c"
        XCTAssertEqual(expected, shared.sha1String(text))
    }

    func testSha256() {
        let expected = "ff640e3eb2f4ce5a3c100a76f247236b0b2eb95776f5bc68151a11cbb3314a80"
        XCTAssertEqual(expected, shared.sha256String(text))
    }

    func testBase64() {
        let expected = "TG9yZW0gaXBzdW0gZG9sb3Igc2l0IGFtZXQsIGNvbnNldGV0dXIgc2FkaXBzY2luZyBlbGl0ci4="
        XCTAssertEqual(expected, shared.base64String(text))
    }
    
    func testBase64Image() {
        let filepath = Bundle.main.path(forResource: "logo128", ofType: "png")!
        let image = UIImage(contentsOfFile: filepath)
        XCTAssertNotNil(shared.base64Image(image))
    }
}
