//
//  TestingAppDelegate.swift
//  PerseusWeatherTests
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © 7531 PerseusRealDeal.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import XCTest
@testable import PerseusWeather

// MARK: - The Testing Application Delegate

@objc(TestingAppDelegate)
class TestingAppDelegate: NSResponder, NSApplicationDelegate {
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        log.message("The app's test bundle start point...", .info)
        log.message("Launching with testing matter purpose", .info)
        log.message("[\(type(of: self))].\(#function)")
    }
}
