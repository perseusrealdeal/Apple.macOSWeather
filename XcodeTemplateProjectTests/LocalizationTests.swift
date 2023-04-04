//
//  LocalizationTests.swift
//  XcodeTemplateProjectTests
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//
//  Before start unit tests, make sure that previous app's installation is removed.
//

import XCTest
@testable import XcodeTemplateProject

class LocalizationTests: XCTestCase {

    private let defaults = UserDefaults.standard

    override class func setUp() {
        super.setUp()

        PerseusLogger.message("[\(type(of: self))].\(#function)")
    }

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }
    // func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    // MARK: - UI tests

    func test_greetings_should_meet_requirement() {

        let greetings_expected = "greetings".localizedFromRequirements
        let greetings_actual = "greetings".localizedValue

        let message_not_equal = "Greetings doesn't meet requirement!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }

    func test_MainViewController_greetings() {

        let mainWindow = MainWindowController.storyboardInstance()
        mainWindow.loadWindow()

        guard let sut = mainWindow.contentViewController as? ViewController else {
            XCTFail("There is no VC loaded!")
            return
        }

        let greetings_expected = "greetings".localizedValue
        let greetings_actual = sut.greetingsLabel.cell?.title

        let message_not_equal = "Something went wrong with localized greetings!"

        XCTAssertEqual(greetings_expected, greetings_actual, message_not_equal)
    }
}
