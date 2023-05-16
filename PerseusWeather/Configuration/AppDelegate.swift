//
//  AppDelegate.swift
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
import CoreLocation
import PerseusGeoLocationKit

class AppDelegate: NSObject, NSApplicationDelegate {

    let dealer = AppGlobals.locationDealer
    let client = AppGlobals.weatherClient

    var location: PerseusLocation? {
        didSet {
            log.message(String(describing: location))
        }
    }

    var weather: Data? {
        didSet {
            log.message(String(describing: weather))
        }
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {

        log.message("Launching with business matter purpose", .info)
        log.message("[\(type(of: self))].\(#function)")

        AppearanceService.makeUp()
        addAbservers()

        // let dealer = AppGlobals.locationDealer
/*
        dealer.askForAuthorization { permit in
            let text = "[\(type(of: self))].\(#function) — It's already determined .\(permit)"
            log.message(text, .error)
        }
*/
        // try? dealer.askForCurrentLocation()

        client.onDataGiven = { result in
            switch result {
            case .success(let weatherData):
                self.weatherDataHandler(weatherData)
            case .failure(let error):
                switch error {
                case .failedRequest(let message):
                    log.message(message, .error)
                default:
                    break
                }
            }
        }
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }

    private func addAbservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(locationDealerCurrentHandler(_:)),
            name: .locationDealerCurrentNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(locationDealerUpdatesHandler(_:)),
            name: .locationDealerUpdatesNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(locationDealerErrorHandler(_:)),
            name: .locationDealerErrorNotification,
            object: nil
        )

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(locationDealerStatusChangedHandler(_:)),
            name: .locationDealerStatusChangedNotification,
            object: nil
        )
    }

    @objc private func locationDealerCurrentHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")
        guard
            let result = notification.object as? Result<PerseusLocation, LocationDealerError>
            else { return }

        switch result {
        case .success(let data):
            self.location = data
        case .failure(let error):
            log.message("\(error)", .error)
        }
    }

    @objc private func locationDealerUpdatesHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")
        guard
            let result = notification.object as? Result<[PerseusLocation], LocationDealerError>
        else { return }

        switch result {
        case .success(let data):
            log.message("Locations count: \(data.count)")
        case .failure(let error):
            log.message("\(error)", .error)
        }
    }

    @objc private func locationDealerErrorHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")
        guard let result = notification.object as? LocationDealerError else { return }
        log.message("\(result)", .error)
    }

    @objc private func locationDealerStatusChangedHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")

        guard let result = notification.object as? CLAuthorizationStatus else { return }
        log.message("[\(type(of: self))] Location Manager Status: \(result)")

        let permit = AppGlobals.locationDealer.locationPermit
        log.message("[\(type(of: self))] Location Manager Permit: \(permit)")
    }

    private func weatherDataHandler(_ data: Data) {
        log.message("""
            DATA: BEGIN
            \(String(decoding: data, as: UTF8.self))
            DATA: END
            """)
    }
}
