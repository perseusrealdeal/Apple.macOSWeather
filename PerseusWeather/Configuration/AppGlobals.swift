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

import Foundation

struct AppGlobals {

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    // MARK: - Custom Services

    static let locationDealer = PerseusLocationDealer.shared
}
