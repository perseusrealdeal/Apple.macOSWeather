//
//  AppGlobals.swift
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

import Cocoa

struct AppGlobals {

    // MARK: - Constants

    static let appKeyOpenWeather = "79eefe16f6e4714470502074369fc77b"

    static let statusMenusButtonIconName = "Icon"
    static let statusMenusButtonTitle = "Text"

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    static var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }

    static let openSystemApp = "x-apple.systempreferences:"

    // MARK: - Custom Services

    public let locationDealer: PerseusLocationDealer
    public let weatherClient: OpenWeatherFreeClient

    public let statusMenusButtonPresenter: StatusMenusButtonPresenter
    public let preferencesPresenter: PreferencesWindowController

    public let languageSwitcher: LanguageSwitcher
    public let dataDefender: PerseusDataDefender

    init() {
        log.message("[AppGlobals].\(#function)")

        self.locationDealer = PerseusLocationDealer.shared
        self.weatherClient = OpenWeatherFreeClient()
        self.statusMenusButtonPresenter = StatusMenusButtonPresenter()
        self.preferencesPresenter = PreferencesWindowController.storyboardInstance()

        self.languageSwitcher = LanguageSwitcher.shared
        self.dataDefender = PerseusDataDefender.shared
    }
}
