//
//  OptionsWindowController.swift, OptionsWindowController.storyboard
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

public class OptionsWindowController: NSWindowController, NSWindowDelegate {

    // MARK: - Internals

    private var alwaysOnTop: Any?
    private let darkModeObserver = DarkModeObserver()

    // MARK: - Initialization

    public override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")

        let nc = AppGlobals.notificationCenter

        // Always on top.

        let notification = NSApplication.didResignActiveNotification
        let queue = OperationQueue.main

        alwaysOnTop = nc.addObserver(forName: notification,
                                     object: nil,
                                     queue: queue) { _ in self.window?.level = .floating }

        // Dark Mode.

        darkModeObserver.action = { _ in self.makeup() }

        // Localization.

        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        // Apperance.

        makeup()
        localize()
    }

    public override func windowDidLoad() {
        super.windowDidLoad()

        log.message("[\(type(of: self))].\(#function)")
    }

    // MARK: - Other methods

    public func windowShouldClose(_ sender: NSWindow) -> Bool {

        log.message("[\(type(of: self))].\(#function)")

        self.window?.orderOut(sender)
        return false
    }
}

// MARK: - STORYBOARD INSTANCE

extension OptionsWindowController {

    class func storyboardInstance() -> OptionsWindowController {

        log.message("[\(type(of: self))].\(#function)")

        let sb = NSStoryboard(name: String(describing: self), bundle: nil)

        guard
            let screen = sb.instantiateInitialController() as? OptionsWindowController
        else {

            let text = "[\(type(of: self))].\(#function)"

            log.message(text, .error)
            fatalError(text)
        }

        // Do default setup; don't set any parameter causing loadWindow up, breaks unit tests.

        return screen
    }
}

// MARK: - DARK MODE

extension OptionsWindowController {

    public func makeup() {

        guard
            let screen = self.contentViewController as? OptionsViewController
        else {
            return
        }

        screen.makeup()
    }
}

// MARK: - LOCALIZATION

extension OptionsWindowController: Localizable {

    @objc func localize() {

        guard
            let screen = self.contentViewController as? OptionsViewController
        else {
            return
        }

        screen.localize()
    }
}
