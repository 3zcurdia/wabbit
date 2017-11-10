//
//  WabbitUITests.swift
//  WabbitUITests
//
//  Created by Luis Ezcurdia on 11/1/17.
//  Copyright © 2017 Luis Ezcurdia. All rights reserved.
//

import XCTest

class WabbitUITests: XCTestCase {

    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
    }

    func testRunBenchmarks() {
        snapshot("0-Launch")
        XCUIApplication().collectionViews.cells.children(matching: .textView).element.swipeDown()
        snapshot("1-TriggerBenchmarks")

        XCUIDevice.shared.orientation = .landscapeRight
        snapshot("2-LandscapeLeft")
    }

}
