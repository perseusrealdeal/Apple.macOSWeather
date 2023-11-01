//
//  StatusMenusButtonPresenter.swift
//  PerseusWeather
//
//  Created by Mikhail Zhigulin in 7532.
//
//  Copyright © 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7532 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import Cocoa

class StatusMenusButtonPresenter {

    private lazy var theStatusMenu = { () -> NSMenu in
        let nib = NSNib(nibNamed: NSNib.Name("MainMenu"), bundle: nil)

        var topLevelArray: NSArray?
        _ = nib?.instantiate(withOwner: self, topLevelObjects: &topLevelArray)

        let objects = [Any](topLevelArray!).filter { $0 is NSMenu }
        let theMenu = objects.last as? TheMenu

        return theMenu?.theMenu ?? NSMenu()
    }()

    var statusMenusButton: NSStatusItem? {
        didSet {
            if let button = statusMenusButton?.button {
                button.title = AppGlobals.statusMenusButtonTitle

                button.target = self
                button.action = #selector(statusMenusButtonTapped(_:))
            }
        }
    }

    @objc func statusMenusButtonTapped(_ sender: Any?) {
        let text = "Abstract sentence."
        let textAuthor = "Nobody"

        print("\(text) — \(textAuthor)")
    }

    func setup() {
        log.message("[\(type(of: self))].\(#function)")

        statusMenusButton = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength)

        statusMenusButton?.menu = theStatusMenu
    }
}
