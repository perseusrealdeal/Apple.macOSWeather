//
//  OptionsLocalizationTests.swift
//  SnowmanTests
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
//  Before start unit tests, make sure that previous app's installation is removed.
//

import XCTest
@testable import Snowman

class OptionsLocalizationTests: XCTestCase {

    // private let defaults = UserDefaults.standard

    override class func setUp() {
        super.setUp()
        // log.message("[\(type(of: self))].\(#function)")
    }

    override class func tearDown() {
        // log.message("[\(type(of: self))].\(#function)")
        super.tearDown()
    }

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }
    // func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    // MARK: - UI tests
    /*
    func test_greetings_should_meet_requirement() {

        let greetings_expected = "greetings".localizedFromRequirements
        let greetings_actual = "greetings".localizedValue

        let message_not_equal = "Greetings doesn't meet requirement!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }

    func test_MainViewController_greetings() {

        guard let sut = PopoverViewController.storyboardInstance() as? PopoverViewController
        else {
            XCTFail("There is no VC loaded!")
            return
        }

        let greetings_expected = "greetings".localizedValue
        let greetings_actual = sut.madeWithLoveLabel.stringValue

        let message_not_equal = "Something went wrong with localized greetings!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }
    */
}
