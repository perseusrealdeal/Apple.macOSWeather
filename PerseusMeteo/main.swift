//
//  main.swift
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

import class PerseusDarkMode.PerseusLogger
import class PerseusUISystemKit.PerseusLogger
import class PerseusGeoLocationKit.PerseusLogger
import class OpenWeatherFreeClient.PerseusLogger

typealias PerseusDarkModeLogger = PerseusDarkMode.PerseusLogger
typealias PerseusUISystemKitLogger = PerseusUISystemKit.PerseusLogger
typealias PerseusGeoLocationKitLogger = PerseusGeoLocationKit.PerseusLogger
typealias OpenWeatherFreeClientLogger = OpenWeatherFreeClient.PerseusLogger

// MARK: - Logger

log.level = .info
log.turned = .on

// MARK: - External Loggers

PerseusDarkModeLogger.turned = .on
PerseusUISystemKitLogger.turned = .on
PerseusGeoLocationKitLogger.turned = .on
OpenWeatherFreeClientLogger.turned = .on

// MARK: - Construct the app's top elements

log.message("The app's start point...", .info)
log.message("", .info)

let app = NSApplication.shared

let appPurpose = NSClassFromString("TestingAppDelegate") as? NSObject.Type
let appDelegate = appPurpose?.init() ?? AppDelegate()

let globals = AppGlobals()

// MARK: - Make the app run

/*

 .accessory

 The application doesn’t appear in the Dock and doesn’t have a menu bar, but it may be
 activated programmatically or by clicking on one of its windows.

 */

app.setActivationPolicy(.accessory)

app.delegate = appDelegate as? NSApplicationDelegate

app.activate(ignoringOtherApps: true)
app.run()
