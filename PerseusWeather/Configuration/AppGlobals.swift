//
//  AppGlobals.swift
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © PerseusRealDeal.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Cocoa

struct AppGlobals {

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    static var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }

    // MARK: - Custom Services

    static let locationDealer = PerseusLocationDealer.shared
    static let weatherClient = OpenWeatherFreeClient()
}
