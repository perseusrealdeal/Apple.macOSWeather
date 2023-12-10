//
//  PreferencesConnectionsTests.swift
//  PerseusWeatherTests
//
//  Created by Mikhail Zhigulin in 7532.
//
//  Copyright © 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7532 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import XCTest
@testable import PerseusWeather

class PreferencesConnectionsTests: XCTestCase {

    private var sut: PreferencesWindowController!
    private var viewController: PreferencesViewController!

    override func setUp() {
        super.setUp()

        sut = PreferencesWindowController.storyboardInstance()
        viewController = sut.contentViewController as? PreferencesViewController
    }

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }

    func test_contentViewController_not_nil() {
        let message = "The window's view controller not loaded."
        XCTAssertNotNil(sut.contentViewController, message)
    }

    func test_ib_outlet_controlDarkMode_is_connected() {
        let message = "The outlet controlDarkMode not connected."
        XCTAssertNotNil(viewController?.controlDarkMode, message)
    }

    func test_ib_outlet_controlStartsOnLogin_is_connected() {
        let message = "The outlet controlStartsOnLogin not connected."
        XCTAssertNotNil(viewController?.controlStartsOnLogin, message)
    }

    func test_ib_outlet_controlOpenWeatherKey_is_connected() {
        let message = "The outlet controlOpenWeatherKey not connected."
        XCTAssertNotNil(viewController?.controlOpenWeatherKey, message)
    }

    func test_ib_outlet_controlUnlockButton_is_connected() {
        let message = "The outlet controlUnlockButton not connected."
        XCTAssertNotNil(viewController?.controlUnlockButton, message)
    }

    func test_ib_outlet_controlLanguage_is_connected() {
        let message = "The outlet controlLanguage not connected."
        XCTAssertNotNil(viewController?.controlLanguage, message)
    }
}
