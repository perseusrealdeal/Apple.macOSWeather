//
//  StatusMenusButtonPresenter.swift
//  PerseusMeteo
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

    private var isReadyToCall = false

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

        // Setup weather data source.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(meteoDataOptionsDidChanged),
                       name: NSNotification.Name.weatherUnitsOptionsDidChanged,
                       object: nil)
    }

    public func setupCallerLogic(for caller: OpenWeatherFreeClient) {

        log.message("[\(type(of: self))].\(#function)")

        caller.onDataGiven = { result in

            if let controller = self.popoverScreen as? PopoverViewController {
                DispatchQueue.main.async {
                    controller.stopAnimationProgressIndicator(nil)
                }
            }

            switch result {
            case .success(let weatherData):
                self.weatherOnDataGivenHandler(weatherData)

            case .failure(let error):
                switch error {
                case .failedRequest(let message):
                    log.message(message, .error)
                    self.isReadyToCall = true

                default:
                    log.message("[\(type(of: self))].\(#function) \(error)", .error)
                    self.isReadyToCall = true
                }
            }
        }

        isReadyToCall = true
    }

    public func callWeather(_ sender: Any?) {

        guard isReadyToCall, let location = AppGlobals.appDelegate?.location,
              let controller = self.popoverScreen as? PopoverViewController
        else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return
        }

        isReadyToCall = false

        let lat = location.latitude.cut(.two).description
        let lon = location.longitude.cut(.two).description
        let lang = globals.languageSwitcher.languageCalculated

        let callDetails = OpenWeatherDetails(appid: AppGlobals.appKeyOpenWeather,
                                             format: .currentWeather,
                                             lat: lat,
                                             lon: lon,
                                             units: .imperial,
                                             lang: .init(rawValue: lang),
                                             mode: .json)

        log.message(callDetails.urlString)

        do {
            controller.startAnimationProgressIndicator(sender)
            try globals.weatherClient.call(with: callDetails)
        } catch {

            log.message("[\(type(of: self))].\(#function)", .error)

            controller.stopAnimationProgressIndicator(sender)
            isReadyToCall = true
        }
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
        guard let controller = self.popoverScreen as? PopoverViewController else { return }

        DispatchQueue.main.async {

            AppGlobals.appDelegate?.weather = data

            self.isReadyToCall = true

            controller.reloadData()
        }
    }

    @objc func meteoDataOptionsDidChanged() {
        guard let controller = self.popoverScreen as? PopoverViewController else { return }

        controller.reloadData()
    }
}
