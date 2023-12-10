//
//  BundleTests.swift
//  PerseusWeatherTests
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7531 - 7532 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import XCTest
import Cocoa

@testable import PerseusWeather

class PerseusWeatherTests: XCTestCase {

    override class func setUp() {
        super.setUp()
        log.message("[\(type(of: self))].\(#function)")
    }

    override class func tearDown() {
        log.message("[\(type(of: self))].\(#function)")
        super.tearDown()
    }

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }

    func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    func test_CFBundleDisplayName_should_meet_requirement() {
        let greetings_expected = "CFBundleDisplayName".localizedFromRequirements
        let greetings_actual =
            Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String

        let message_not_equal = "CFBundleDisplayName doesn't meet requirement!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }

    func test_CFBundleName_should_meet_requirement() {
        let greetings_expected = "CFBundleName".localizedFromRequirements
        let greetings_actual = Bundle.main.localizedInfoDictionary?["CFBundleName"] as? String

        let message_not_equal = "CFBundleName doesn't meet requirement!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }

    func test_ActivationPolicy_is_accessory() {
        let activationPolicy_expected = NSApplication.ActivationPolicy.accessory
        let activationPolicy_actual = NSApplication.shared.activationPolicy()

        let message_not_equal = "ActivationPolicy must be in .accessory!"

        XCTAssertEqual(activationPolicy_expected, activationPolicy_actual, message_not_equal)
    }
}
