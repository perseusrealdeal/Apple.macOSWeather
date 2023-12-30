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

    var isReadyToCall = false

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

    public func setupCallerLogic(for caller: OpenWeatherFreeClient) {

        log.message("[\(type(of: self))].\(#function)")

        caller.onDataGiven = { result in

            switch result {
            case .success(let weatherData):
                self.weatherOnDataGivenHandler(weatherData)

            case .failure(let error):
                switch error {
                case .failedRequest(let message):
                    log.message(message, .error)
                    self.isReadyToCall = true

                default:
                    log.message("[FreeNetworkClient].\(#function) \(error)", .error)
                }
            }
        }

        isReadyToCall = true
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

    private func weatherOnDataGivenHandler(_ data: Data) {

        log.message("[\(type(of: self))].\(#function)\n" + """
            DATA: BEGIN
            \(String(decoding: data, as: UTF8.self))
            DATA: END
            """)

        guard let controller = self.popoverScreen as? PopoverViewController else { return }

        DispatchQueue.main.async {
            controller.reloadData()
            self.isReadyToCall = true
        }
    }
}
