//
//  AppDelegate.swift
//  PerseusMeteo
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
import CoreLocation

class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Business Data

    var location: PerseusLocation? {
        didSet {
            log.message(String(describing: location))
        }
    }

    var weather: Data? {
        didSet {
            log.message("[\(type(of: self))].\(#function)\n" + """
                DATA: BEGIN
                \(String(decoding: weather ?? Data(), as: UTF8.self))
                DATA: END
                """)
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
