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

import AppKit

class StatusMenusButtonPresenter {

    // MARK: - Properties

    var statusItem: NSStatusItem?

    var popover: NSPopover? {
        didSet {
            popover?.behavior = .transient
        }
    }

    var popoverScreen: NSViewController?

    // MARK: - Initialization

    init() {

        log.message("[\(type(of: self))].\(#function)")

        // Setup status menus button.

        statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

        statusItem?.button?.imagePosition = .imageLeft
        statusItem?.button?.image = NSImage(named: AppGlobals.statusMenusButtonIconName)
        statusItem?.button?.title = AppGlobals.statusMenusButtonTitle

        statusItem?.button?.target = self
        statusItem?.button?.action = #selector(statusMenusButtonTapped)

        // Setup popover and screen.

        popover = NSPopover()
        popoverScreen = PopoverViewController.storyboardInstance()
    }

    // MARK: - Event handlers

    @objc private func statusMenusButtonTapped() {

        log.message("[\(type(of: self))].\(#function)")

        guard let popover = popover, let button = statusItem?.button else { return }

        if popover.isShown {
            popover.performClose(button)
            globals.aboutPresenter.close()
            globals.optionsPresenter.close()
        } else {
            popover.contentViewController = popoverScreen
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: .minY)
        }
    }
}
