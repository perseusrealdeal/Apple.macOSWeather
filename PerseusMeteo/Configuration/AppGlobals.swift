//
//  AppGlobals.swift
//  PerseusMeteo
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7531 - 7532 PerseusRealDeal
//
//  The year starts from the creation of the world in the Star temple
//  according to a Slavic calendar. September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import Cocoa
import PerseusGeoLocationKit

struct AppGlobals {

    // MARK: - Constants

    static let appKeyOpenWeather = "79eefe16f6e4714470502074369fc77b"

    static let statusMenusButtonIconName = "Icon"
    static let statusMenusButtonTitle = "Snowman"
    static let meteoProviderName = "/\\__/\\"

    static var systemOptionsAppName: String? {

        var calculatedTitle: String?

        if #available(macOS 10.14, *) {
            calculatedTitle = "System Settings.app"
        } else {
            calculatedTitle = "System Preferences.app"
        }

        return calculatedTitle
    }

    // MARK: - System Services

    static let userDefaults = UserDefaults.standard
    static let notificationCenter = NotificationCenter.default

    static var appDelegate: AppDelegate? {
        return NSApplication.shared.delegate as? AppDelegate
    }

    static var workspace: NSWorkspace {
        return NSWorkspace.shared
    }

    static let openSystemApp = "x-apple.systempreferences:"

    // MARK: - Custom Services

    public let locationDealer: PerseusLocationDealer

    public let statusMenusButtonPresenter: StatusMenusButtonPresenter

    public let languageSwitcher: LanguageSwitcher
    public let dataDefender: PerseusDataDefender

    // MARK: - Data parsers for UI

    public let sourceCurrentWeather = CurrentDataSource()
    public let sourceForecast = ForecastDataSource()

    init() {

        log.message("[AppGlobals].\(#function)")

        self.locationDealer = PerseusLocationDealer.shared

        self.statusMenusButtonPresenter = StatusMenusButtonPresenter()

        self.languageSwitcher = LanguageSwitcher.shared
        self.dataDefender = PerseusDataDefender.shared

        self.sourceCurrentWeather.path = { AppGlobals.appDelegate?.weather ?? Data() }
        self.sourceForecast.path = { AppGlobals.appDelegate?.forecast ?? Data() }
    }

    static func openDefaultBrowser(string link: String) {

        log.message("[\(type(of: self))].\(#function)")

        guard let url = NSURL(string: link) as URL? else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return
        }

        _ = workspace.open(url) ?
        log.message("[\(type(of: self))].\(#function) - Default browser was opened.") :
        log.message("[\(type(of: self))].\(#function) - Default browser wasn't opened.")
    }

    static func openTheApp(name: String?) {

        /* One way to open System options app */

        let mger = FileManager.default

        guard
            let theAppName = name,
            let pathFirst = mger.urls(for: .applicationDirectory, in: .systemDomainMask).first
        else {
            return
        }

        /* Another way to open System options app */
        // guard let pathURL = URL(string: AppGlobals.openSystemApp) else { return }

        NSWorkspace.shared.open(pathFirst.appendingPathComponent(theAppName))
    }

    static func quitTheApp() {
        app.terminate(appDelegate)
    }
}
