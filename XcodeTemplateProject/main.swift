//
//  main.swift
//  XcodeTemplateProject
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Cocoa

// MARK: - Logger

PerseusLogger.level = .info

// MARK: - Construct the app's top elements

let app = NSApplication.shared

let appPurpose = NSClassFromString("TestingAppDelegate") as? NSObject.Type
let appDelegate = appPurpose?.init() ?? AppDelegate()

let storyboard = NSStoryboard(name: String(describing: MainWindowController.self), bundle: nil)
let screen = storyboard.instantiateInitialController() as? NSWindowController
let mainMenu = NSNib(nibNamed: NSNib.Name("MainMenu"), bundle: nil)

// MARK: - Make the app run

app.setActivationPolicy(.regular)

mainMenu?.instantiate(withOwner: app, topLevelObjects: nil)
screen?.window?.makeKeyAndOrderFront(nil)

app.delegate = appDelegate as? NSApplicationDelegate

app.activate(ignoringOtherApps: true)
app.run()
