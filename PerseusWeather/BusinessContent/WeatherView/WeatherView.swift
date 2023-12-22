//
//  WeatherView.swift, WeatherView.xib
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

class WeatherView: NSView, Localizable {

    @IBOutlet weak var temperatureValueLabel: NSTextField!
    @IBOutlet weak var temperatureUnitLabel: NSTextField!

    @IBOutlet weak var weatherConditionIcon: NSImageView!
    @IBOutlet weak var weatherConditionText: NSTextField!

    @IBOutlet weak var visibilityLabel: NSTextField!
    @IBOutlet weak var visibilityValueLabel: NSTextField!
    @IBOutlet weak var visibilityUnitLabel: NSTextField!

    @IBOutlet weak var feelsLikeLabel: NSTextField!
    @IBOutlet weak var feelsLikeValueLabel: NSTextField!
    @IBOutlet weak var feelsLikeUnitLabel: NSTextField!

    @IBOutlet weak var windSpeedLabel: NSTextField!
    @IBOutlet weak var windSpeedValueLabel: NSTextField!
    @IBOutlet weak var windSpeedUnitLabel: NSTextField!

    @IBOutlet weak var windGustLabel: NSTextField!
    @IBOutlet weak var windGustValueLabel: NSTextField!
    @IBOutlet weak var windGustUnitLabel: NSTextField!

    @IBOutlet weak var sunrizeLabel: NSTextField!
    @IBOutlet weak var sunsetLabel: NSTextField!

    @IBOutlet weak var refreshButton: NSButton!
    @IBOutlet var weatherAlerts: NSTextView!

    @IBAction func refreshButtonTapped(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function)")

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

    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")

        let nc = AppGlobals.notificationCenter
        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        configure()
    }

    @objc func localize() {
        visibilityLabel.stringValue = "Visibility".localizedValue + ":"
        visibilityUnitLabel.stringValue = "km".localizedValue

        weatherConditionText.stringValue = "Text Weather Condition...".localizedValue
        feelsLikeLabel.stringValue = "Feels like".localizedValue + ":"

        windSpeedLabel.stringValue = "Wind Speed".localizedValue + ":"
        windSpeedUnitLabel.stringValue = "m/s".localizedValue

        windGustLabel.stringValue = "Wind Gust".localizedValue + ":"
        windGustUnitLabel.stringValue = "m/s".localizedValue

        sunrizeLabel.stringValue = "SUNRIZE".localizedValue
        sunsetLabel.stringValue = "SUNSET".localizedValue

        refreshButton.title = "RefreshButton".localizedValue

        weatherAlerts.string = ""
        for _ in 1...4 {
            weatherAlerts.string += ("> " +
                "Weather alerts, dangers...".localizedValue + "\n\n")
        }
    }

    private func configure() {
        weatherAlerts.backgroundColor = .clear

        // Default values sketch setup

        temperatureValueLabel.stringValue = "-77"
        temperatureUnitLabel.stringValue = "°C"

        visibilityValueLabel.stringValue = "5"
        feelsLikeValueLabel.stringValue = "-55"
        feelsLikeUnitLabel.stringValue = "°C"

        windSpeedValueLabel.stringValue = "6.0"
        windGustValueLabel.stringValue = "1.16"
    }
}
