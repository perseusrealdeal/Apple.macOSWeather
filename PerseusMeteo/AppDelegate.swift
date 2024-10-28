//
//  AppDelegate.swift
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

import PerseusDarkMode
import PerseusGeoLocationKit

import ConsolePerseusLogger

class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Business Data

    var location: PerseusLocation? {
        didSet {
            log.message(String(describing: location))
        }
    }

    var weather: Data? {
        didSet {
            let text = "JSON:\n\(weather?.prettyPrinted ?? "")"
            log.message("[\(type(of: self))].\(#function)\n\(text)")
        }
    }

    var forecast: Data? {
        didSet {
            let text = "JSON:\n\(forecast?.prettyPrinted ?? "")"
            log.message("[\(type(of: self))].\(#function)\n\(text)")

            // Save the date and time of the last one.

            let src = globals.statusMenusButtonPresenter.screenPopover.viewForecast.dataSource
            let currentTimeInUTC = Date().timeIntervalSince1970

            src.addResponseDateAndTime(dt: Int(currentTimeInUTC))
        }
    }

    // MARK: - On Launch...

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        log.message("Launching with business matter purpose...", .info)
        log.message("[\(type(of: self))].\(#function)")

        AppearanceService.makeUp()

        globals.languageSwitcher.switchLanguageIfNeeded(AppOptions.languageOption)
    }
}
