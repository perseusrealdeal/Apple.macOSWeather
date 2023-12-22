//
//  LocationView.swift, LocationView.xib
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

class LocationView: NSView, Localizable {

    @IBOutlet weak var locationNameValueLabel: NSTextField!

    @IBOutlet weak var permissionLabel: NSTextField!
    @IBOutlet weak var permissionValueLabel: NSTextField!

    @IBOutlet weak var geoCoordinatesValueLabel: NSTextField!

    @IBOutlet weak var refreshButton: NSButton!

    @IBAction func refreshButtonTapped(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function)")

        let permit = globals.locationDealer.locationPermit

        if permit == .notDetermined {
            // Allow geo service
            globals.locationDealer.askForAuthorization { permit in
                let text = "[\(type(of: self))].\(#function) — .\(permit)"
                log.message(text, .error)
            }
        } else if permit == .allowed {
            // Refresh geo data
            try? globals.locationDealer.askForCurrentLocation()
        } else {
            // Open system options
            AppGlobals.openTheApp(name: AppGlobals.systemAppName)
        }
    }

    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerCurrentHandler(_:)),
                       name: .locationDealerCurrentNotification,
                       object: nil
        )
    }

    override func viewWillDraw() {
        log.message("[\(type(of: self))].\(#function)")
        updateViewValues()
    }

    @objc func localize() {
        log.message("[\(type(of: self))].\(#function)")

        locationNameValueLabel.stringValue = "Location Name Label".localizedValue

        permissionLabel.stringValue = "Permission".localizedValue + ":"
        permissionValueLabel.stringValue = self.permissionStatusLocalized

        geoCoordinatesValueLabel.stringValue = self.geoCoordinatesCouple

        refreshButton.title = self.refreshButtonTitle
    }

    @objc private func locationDealerCurrentHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")

        guard
            let result = notification.object as? Result<PerseusLocation, LocationDealerError>
            else { return }

        switch result {
        case .success(let data):
            AppGlobals.appDelegate?.location = data
        case .failure(let error):
            log.message("\(error)", .error)
        }

        updateViewValues()
    }

    private func updateViewValues() {
        permissionValueLabel.stringValue = self.permissionStatusLocalized
        geoCoordinatesValueLabel.stringValue = self.geoCoordinatesCouple
        refreshButton.title = self.refreshButtonTitle
    }
}

extension LocationView {

    private var permissionStatusLocalized: String {

        let permit = globals.locationDealer.locationPermit
        var statusLocalized: String = ""

        switch permit {
        case .notDetermined:
            statusLocalized = "notDetermined Location Status".localizedValue
        case .deniedForAllAndRestricted:
            statusLocalized = "deniedForAllAndRestricted Location Status".localizedValue
        case .restricted:
            statusLocalized = "restricted Location Status".localizedValue
        case .deniedForAllApps:
            statusLocalized = "deniedForAllApps Location Status".localizedValue
        case .deniedForTheApp:
            statusLocalized = "deniedForTheApp Location Status".localizedValue
        case .allowed:
            statusLocalized = "allowed Location Status".localizedValue
        }

        return statusLocalized
    }

    private var geoCoordinatesCouple: String {

        guard let location = AppGlobals.appDelegate?.location else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return "Latitude, Longitude Label".localizedValue
        }

        let couple = "\(location.latitude.cut(.four)), \(location.longitude.cut(.four))"
        log.message("[\(type(of: self))].\(#function) \(couple)")

        return couple
    }

    private var refreshButtonTitle: String {

        let permit = globals.locationDealer.locationPermit
        var titleLocalized: String = ""

        switch permit {
        case .notDetermined:
            titleLocalized = "Allow Geo Service LocationButton".localizedValue
        case .deniedForAllAndRestricted:
            titleLocalized = "Go to Settings... LocationButton".localizedValue
        case .restricted:
            titleLocalized = "Go to Settings... LocationButton".localizedValue
        case .deniedForAllApps:
            titleLocalized = "Go to Settings... LocationButton".localizedValue
        case .deniedForTheApp:
            titleLocalized = "Go to Settings... LocationButton".localizedValue
        case .allowed:
            titleLocalized = "Refresh LocationButton".localizedValue
        }

        return titleLocalized
    }
}
