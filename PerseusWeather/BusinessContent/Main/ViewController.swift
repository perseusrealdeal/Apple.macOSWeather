//
//  ViewController.swift
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

class ViewController: NSViewController {

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
        localizeContent()
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
}
