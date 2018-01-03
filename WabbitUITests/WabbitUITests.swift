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
        let app = XCUIApplication()
        app.otherElements.containing(.staticText, identifier:"Tap to start benchmark").children(matching: .other).element.tap()
        snapshot("1-textResults")
        XCUIApplication().collectionViews/*@START_MENU_TOKEN@*/.collectionViews.staticTexts["\tPrime"]/*[[".cells.collectionViews",".cells.staticTexts[\"\\tPrime\"]",".staticTexts[\"\\tPrime\"]",".collectionViews"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.swipeLeft()
        snapshot("2-graphResults")
    }

}
