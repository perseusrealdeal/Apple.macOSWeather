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
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class WeatherView: NSView {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()
    public let dataSource = MeteoDataParser()

    // MARK: - Outlets

    @IBOutlet private(set) var contentView: NSView!

    @IBOutlet private(set) weak var meteoDataByLabel: NSTextField!
    @IBOutlet private(set) weak var meteoProviderNameLabel: NSTextField!

    @IBOutlet private(set) weak var feelsLikeLabel: NSTextField!
    @IBOutlet private(set) weak var miniMaxTemperatureLabel: NSTextField!

    @IBOutlet private(set) weak var humidityLabel: NSTextField!
    @IBOutlet private(set) weak var visibilityLabel: NSTextField!

    @IBOutlet private(set) weak var weatherConditionIcon: NSImageView!
    @IBOutlet private(set) weak var temperatureValue: NSTextField!
    @IBOutlet private(set) weak var weatherConditionLabel: NSTextField!

    @IBOutlet private(set) weak var windSpeedLabel: NSTextField!
    @IBOutlet private(set) weak var windSpeedValue: NSTextField!
    @IBOutlet private(set) weak var windDirectionLabel: NSTextField!
    @IBOutlet private(set) weak var windDirectionValue: NSTextField!
    @IBOutlet private(set) weak var windGustsLabel: NSTextField!
    @IBOutlet private(set) weak var windGustsValue: NSTextField!

    @IBOutlet private(set) weak var pressureLabel: NSTextField!
    @IBOutlet private(set) weak var pressureValue: NSTextField!
    @IBOutlet private(set) weak var sunriseLabel: NSTextField!
    @IBOutlet private(set) weak var sunriseValue: NSTextField!
    @IBOutlet private(set) weak var sunsetLabel: NSTextField!
    @IBOutlet private(set) weak var sunsetValue: NSTextField!

    // MARK: - Initialization

    override func viewWillDraw() {
        super.viewWillDraw()

        log.message("[\(type(of: self))].\(#function)")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        log.message("[\(type(of: self))].\(#function)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")

        localize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        log.message("[\(type(of: self))].\(#function)")

        // Create a new instance from *xib and reference it to contentView outlet.

        guard let className = type(of: self).className().components(separatedBy: ".").last,
              let nib = NSNib(nibNamed: className, bundle: Bundle(for: type(of: self)))
        else {
            let text = "[\(type(of: self))].\(#function) No nib loaded."
            log.message(text, .error); fatalError(text)
        }

        log.message("[\(type(of: self))].\(#function) \(className)")

        nib.instantiate(withOwner: self, topLevelObjects: nil)

        var newConstraints: [NSLayoutConstraint] = []

        for oldConstraint in contentView.constraints {

            let firstItem = oldConstraint.firstItem === contentView ?
            self : oldConstraint.firstItem

            let secondItem = oldConstraint.secondItem === contentView ?
            self : oldConstraint.secondItem

            newConstraints.append(
                NSLayoutConstraint(item: firstItem as Any,
                                   attribute: oldConstraint.firstAttribute,
                                   relatedBy: oldConstraint.relation,
                                   toItem: secondItem,
                                   attribute: oldConstraint.secondAttribute,
                                   multiplier: oldConstraint.multiplier,
                                   constant: oldConstraint.constant)
            )
        }

        for newView in contentView.subviews {
            self.addSubview(newView)
        }

        self.addConstraints(newConstraints)

        // Setup DARK MODE.

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()

        // Setup localization.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        dataSource.data = { AppGlobals.appDelegate?.weather ?? Data() }
        reloadData()
    }

    // MARK: - Contract

    public func reloadData() {

        log.message("[\(type(of: self))].\(#function)")

        dataSource.refreshValuesIfNeeded()

        // Meteo Data Provider.

        meteoDataByLabel.stringValue = "Meteo Data by".localizedValue
        meteoProviderNameLabel.stringValue = dataSource.meteoDataProviderName

        // Weather Icon and Short desc.

        weatherConditionIcon.image = NSImage(named: dataSource.weatherIconName)
        weatherConditionLabel.stringValue = dataSource.weatherDescription

        // Temperature.

        temperatureValue.stringValue = dataSource.temperature
        feelsLikeLabel.stringValue =
            "Feels like: ".localizedValue + dataSource.temperatureFeelsLike
        miniMaxTemperatureLabel.stringValue =
            "Min: ".localizedValue + dataSource.temperatureMinimum + " / " +
            "Max: ".localizedValue + dataSource.temperatureMaximum

        // Humidity and visibility.

        humidityLabel.stringValue = "Humidity: ".localizedValue + dataSource.humidity
        visibilityLabel.stringValue = "Visibility: ".localizedValue + dataSource.visibility

        // Wind.

        windDirectionLabel.stringValue = "Direction".localizedValue
        windSpeedLabel.stringValue = "Speed".localizedValue
        windGustsLabel.stringValue = "Gusts".localizedValue

        windDirectionValue.stringValue = dataSource.windDirection
        windSpeedValue.stringValue = dataSource.windSpeed
        windGustsValue.stringValue = dataSource.windGusts

        // Pressure.

        pressureLabel.stringValue = "Pressure".localizedValue
        pressureValue.stringValue = dataSource.pressure

        // Sunrise and sunset.

        sunriseLabel.stringValue = "SUNRISE".localizedValue
        sunsetLabel.stringValue = "SUNSET".localizedValue

        sunriseValue.stringValue = dataSource.sunrise
        sunsetValue.stringValue = dataSource.sunset
    }
}

// MARK: - DARK MODE

extension WeatherView {

    private func callDarkModeSensitiveColours() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
    }
}

// MARK: - LOCALIZAION

extension WeatherView {

    @objc func localize() {

        log.message("[\(type(of: self))].\(#function)")

        reloadData()
    }
}
