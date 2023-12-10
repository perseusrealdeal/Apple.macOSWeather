//
//  ViewController.swift
//  PerseusWeather
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

class ViewController: NSViewController, Localizable {

    deinit { log.message("\(type(of: self)).deinit") }

    @IBOutlet private(set) weak var greetingsLabel: NSTextField!

    @IBAction func askForCurrentLocationButtonTapped(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function)")
        do {
            try globals.locationDealer.askForCurrentLocation()
        } catch LocationDealerError.needsPermission(let permit) {
            log.message("[\(type(of: self))].\(#function) — permit: .\(permit)", .error)
        } catch {
            log.message("[\(type(of: self))].\(#function) — unexpected error", .error)
        }
    }

    @IBAction func askForAuthorizationButtonTapped(_ sender: NSButton) {
        let currentPermit = globals.locationDealer.locationPermit
        log.message("[\(type(of: self))].\(#function) — permit: \(currentPermit)")
        globals.locationDealer.askForAuthorization { permit in
            let text = "[\(type(of: self))].\(#function) — It's already determined .\(permit)"
            log.message(text, .error)
        }
    }

    @IBAction func askWeatherButtonTapped(_ sender: NSButton) {

        guard let location = AppGlobals.appDelegate?.location else { return }

        let lat = location.latitude.cut(.two).description
        let lon = location.longitude.cut(.two).description

        let callDetails = OpenWeatherDetails(appid: AppGlobals.appKeyOpenWeather,
                                             format: .currentWeather,
                                             lat: lat,
                                             lon: lon)

        log.message(callDetails.urlString)

        try? globals.weatherClient.call(with: callDetails)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        // localizeContent()
        let nc = AppGlobals.notificationCenter
        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)
    }

    @objc private func makeUp() {
        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")

        greetingsLabel.textColor = .perseusYellow
        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }

    private func localizeContent() {
        // NSLocale.currentLocaleDidChangeNotification
        greetingsLabel.cell?.title = "greetings".localizedValue
    }

    @objc public func localize() {
        log.message("[\(type(of: self))].\(#function)")
        localizeContent()
    }
}
