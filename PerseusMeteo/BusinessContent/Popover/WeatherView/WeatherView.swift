//
//  WeatherView.swift, WeatherView.xib
//  PerseusMeteo
//
//  Created by Mikhail Zhigulin in 7532.
//
//  Copyright © 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7532 PerseusRealDeal
//
//  The year starts from the creation of the world in the Star temple
//  according to a Slavic calendar. September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class WeatherView: NSView {

    // MARK: - View Data Source

    public let dataSource = globals.sourceCurrentWeather
    public var progressIndicator: Bool = false {
        didSet {
            if progressIndicator {
                indicator.isHidden = false
                indicator.startAnimation(nil)
            } else {
                indicator.isHidden = true
                indicator.stopAnimation(nil)
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet private(set) var viewContent: NSView!

    @IBOutlet private(set) weak var labelMeteoProviderTitle: NSTextField!
    @IBOutlet private(set) weak var labelMeteoProviderValue: NSTextField!
    @IBOutlet private(set) weak var indicator: NSProgressIndicator!

    @IBOutlet private(set) weak var viewWeatherConditionIcon: NSImageView!
    @IBOutlet private(set) weak var labelTemperatureValue: NSTextField!
    @IBOutlet private(set) weak var labelWeatherConditionValue: NSTextField!

    @IBOutlet private(set) weak var labelHumidity: NSTextField!

    @IBOutlet private(set) weak var titleMinMaxTemperature: NSTextField!
    @IBOutlet private(set) weak var titleFeelsLike: NSTextField!
    @IBOutlet private(set) weak var titleVisibility: NSTextField!

    @IBOutlet private(set) weak var valueMinMaxTemperature: NSTextField!
    @IBOutlet private(set) weak var valueFeelsLike: NSTextField!
    @IBOutlet private(set) weak var valueVisibility: NSTextField!

    @IBOutlet private(set) weak var labelWindSpeedTitle: NSTextField!
    @IBOutlet private(set) weak var labelWindSpeedValue: NSTextField!
    @IBOutlet private(set) weak var labelWindDirectionTitle: NSTextField!
    @IBOutlet private(set) weak var labelWindDirectionValue: NSTextField!
    @IBOutlet private(set) weak var labelWindGustsTitle: NSTextField!
    @IBOutlet private(set) weak var labelWindGustsValue: NSTextField!

    @IBOutlet private(set) weak var labelPressureTitle: NSTextField!
    @IBOutlet private(set) weak var labelPressureValue: NSTextField!
    @IBOutlet private(set) weak var labelSunriseTitle: NSTextField!
    @IBOutlet private(set) weak var labelSunriseValue: NSTextField!
    @IBOutlet private(set) weak var labelSunsetTitle: NSTextField!
    @IBOutlet private(set) weak var labelSunsetValue: NSTextField!

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
        progressIndicator = false
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

        for oldConstraint in viewContent.constraints {

            let firstItem = oldConstraint.firstItem === viewContent ?
            self : oldConstraint.firstItem

            let secondItem = oldConstraint.secondItem === viewContent ?
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

        for newView in viewContent.subviews {
            self.addSubview(newView)
        }

        self.addConstraints(newConstraints)
    }

    // MARK: - Contract

    public func reloadData() {

        log.message("[\(type(of: self))].\(#function)")

        // Meteo Data Provider.

        labelMeteoProviderTitle.stringValue = "Label: Meteo Data Provider".localizedValue
        labelMeteoProviderValue.stringValue = dataSource.meteoDataProviderName

        // Weather Icon and Short desc.

        viewWeatherConditionIcon.image = NSImage(named: dataSource.weatherIconName)
        labelWeatherConditionValue.stringValue = dataSource.weatherDescription

        // Temperature.

        labelTemperatureValue.stringValue = dataSource.temperature

        titleFeelsLike.stringValue = "Prefix: Feels Like".localizedValue
        valueFeelsLike.stringValue = dataSource.temperatureFeelsLike

        let titleMinMax = "Prefix: Min".localizedValue + ", " + "Prefix: Max".localizedValue
        titleMinMaxTemperature.stringValue = titleMinMax

        let valueMinMax = "\(dataSource.temperatureMinimum) / \(dataSource.temperatureMaximum)"
        valueMinMaxTemperature.stringValue = valueMinMax

        // Humidity and visibility.

        let humidity = "Prefix: Humidity".localizedValue + ": \(dataSource.humidity)"
        labelHumidity.stringValue = humidity

        titleVisibility.stringValue = "Prefix: Visibility".localizedValue
        valueVisibility.stringValue = dataSource.visibility

        // Wind.

        labelWindSpeedTitle.stringValue = "Label: Speed".localizedValue
        labelWindDirectionTitle.stringValue = "Label: Direction".localizedValue
        labelWindGustsTitle.stringValue = "Label: Gust".localizedValue

        labelWindDirectionValue.stringValue = dataSource.windDirection
        labelWindSpeedValue.stringValue = dataSource.windSpeed
        labelWindGustsValue.stringValue = dataSource.windGusts

        // Pressure.

        labelPressureTitle.stringValue = "Label: Pressure".localizedValue
        labelPressureValue.stringValue = dataSource.pressure

        // Sunrise and sunset.

        labelSunriseTitle.stringValue = "Label: Sunrise".localizedValue
        labelSunsetTitle.stringValue = "Label: Sunset".localizedValue

        labelSunriseValue.stringValue = dataSource.sunrise
        labelSunsetValue.stringValue = dataSource.sunset
    }
}

// MARK: - DARK MODE

extension WeatherView {

    public func makeup() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
    }
}

// MARK: - LOCALIZATION

extension WeatherView {

    public func localize() {

        log.message("[\(type(of: self))].\(#function)")

        reloadData()
    }
}
