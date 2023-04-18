//
//  AppDelegate.swift
//  PerseusWeather
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

class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        log.message("Launching with business matter purpose", .info)
        log.message("[\(type(of: self))].\(#function)")

        AppearanceService.makeUp()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}
