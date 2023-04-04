//
//  XcodeTemplateProjectTests.swift
//  XcodeTemplateProjectTests
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import XCTest
@testable import XcodeTemplateProject

class XcodeTemplateProjectTests: XCTestCase {

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
}
