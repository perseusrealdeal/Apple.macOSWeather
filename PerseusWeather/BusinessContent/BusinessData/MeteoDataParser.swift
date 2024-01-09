//
//  MeteoDataParser.swift
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

import Foundation

// MARK: - Refresh

extension MeteoDataParser {

    // MARK: - Contract

    public func refreshValuesIfNeeded() {
        guard let source = json else { return }

        switch dataSourceProvider {
        case .serviceOpenWeatherMap:
            updateFromOpenWeatherMap(source)
        }
    }
}

// MARK: - Weather App values

public class MeteoDataParser: DataParser, DataSourceProtocol {

    public var dataSourceProvider: DataSourceProvider = .serviceOpenWeatherMap {
        didSet {
            log.message("[\(type(of: self))].\(#function)")
        }
    }

    // MARK: - Contract, values ready for reading (viewing on a screen)

    public var lastOne: String { // Last time API request response.
        guard let value = lastOneCalculated, let timezone = timezoneCalculated else {
            return lastOneDefault
        }

        let lastOne = representLastOneCalculationTime(value,
                                                      timezone,
                                                      toBe: AppOptions.timeFormatOption)
        let label = "Last One".localizedValue
        let day = lastOne.day == nil ? "" : "\(lastOne.day ?? "") "

        return "\(label): \(day)\(lastOne.time ?? lastOneDefault)"
    }

    public var meteoDataProviderName: String {
        guard let value = meteoDataProviderNameCalculated else {
            return meteoDataProviderNameDefault
        }

        return value
    }

    public var weatherIconName: String {
        guard let value = weatherIconNameCalculated else {
            return weatherIconNameDefault
        }

        return value
    }

    public var weatherDescription: String {
        guard let value = weatherDescriptionCalculated else {
            return weatherDescriptionDefault
        }

        let represented = "\(String("In brief").localizedValue): \(value)"

        return represented
    }

    public var temperature: String {
        guard let value = temperatureCalculated else {
            return temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(temperatureCurrentUnit)"
    }

    public var temperatureFeelsLike: String {
        guard let value = temperatureFeelsLikeCalculated else {
            return temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(temperatureCurrentUnit)"
    }

    public var temperatureMinimum: String {
        guard let value = temperatureMinimumCalculated else {
            return temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(temperatureCurrentUnit)"
    }

    public var temperatureMaximum: String {
        guard let value = temperatureMaximumCalculated else {
            return temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(temperatureCurrentUnit)"
    }

    public var windSpeed: String {
        guard let value = windSpeedCalculated else {
            return windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(windUnitsLocalized)"
    }

    public var windGusts: String {
        guard let value = windGustsCalculated else {
            return windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(windUnitsLocalized)"
    }

    public var windDirection: String {
        guard let value = windDirectionCalculated else {
            return windDirectionDefault
        }

        // Recalculate if needed.
        let represented = representWindDirection(value)

        return "\(represented)"
    }

    public var pressure: String {
        guard let value = pressureCalculated else {
            return pressureDefault
        }

        // Recalculate if needed.
        let represented = representPressure(value,
                                            asIs: PressureOption.hPa,
                                            toBe: AppOptions.pressureOption)

        return "\(represented) \(pressureUnitsLocalized)"
    }

    public var humidity: String {
        guard let value = humidityCalculated else {
            return humidityDefault
        }

        return "\(value) %"
    }

    public var visibility: String {
        guard let value = visibilityCalculated else {
            return visibilityDefault
        }

        // Recalculate if needed.
        let represented = representDistance(value,
                                            asIs: LengthOption.meter,
                                            toBe: AppOptions.distanceOption)

        return "\(represented) \(distanceUnitsLocalized)"
    }

    public var sunrise: String {
        guard let value = sunriseCalculated, let timezone = timezoneCalculated else {
            return sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? sunrizeSunsetDefault)"
    }

    public var sunset: String {
        guard let value = sunsetCalculated, let timezone = timezoneCalculated else {
            return sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? sunrizeSunsetDefault)"
    }

    // MARK: - Realization

    internal var meteoDataProviderNameCalculated: String?

    internal var weatherIconNameCalculated: String?
    internal var weatherDescriptionCalculated: String?

    internal var temperatureCalculated: String?
    internal var temperatureFeelsLikeCalculated: String?
    internal var temperatureMinimumCalculated: String?
    internal var temperatureMaximumCalculated: String?

    internal var windSpeedCalculated: String?
    internal var windGustsCalculated: String?
    internal var windDirectionCalculated: String?

    internal var pressureCalculated: String?
    internal var humidityCalculated: Int?
    internal var visibilityCalculated: Int?

    internal var sunriseCalculated: Int?
    internal var sunsetCalculated: Int?

    internal var lastOneCalculated: Int?
    internal var timezoneCalculated: Int?

    // MARK: - Values used by default

    private var meteoDataProviderNameDefault: String {
        return "/\\__/\\"
    }

    private var weatherIconNameDefault: String {
        return "Icon"
    }

    private var weatherDescriptionDefault: String {
        return "About weather...".localizedValue
    }

    private var temperatureDefault: String {
        return "\(temperatureCurrentFormat) \(temperatureCurrentUnit)"
    }

    private var windSpeedDefault: String {
        return "\(windSpeedFormat) \(windUnitsLocalized)"
    }

    private var windDirectionDefault: String {
        return  "___° : _/__"
    }

    private var pressureDefault: String {
        return  "____ \(pressureUnitsLocalized)"
    }

    private var humidityDefault: String {
        return  "___ %"
    }

    private var visibilityDefault: String {
        return  "_____ \(distanceUnitsLocalized)"
    }

    private var sunrizeSunsetDefault: String {

        var template = ""

        switch AppOptions.timeFormatOption {
        case .hour24:
            template = "--:--"
        case .hour12:
            template = "--:-- _._."
        case .system:
            template = Date.currentTimeFormat == .hour12 ? "--:-- _._." : "--:--"
        }

        return template
    }

    private var lastOneDefault: String {
        return "Made with Love".localizedValue
    }

    private var temperatureCurrentUnit: String {

        var unit = ""

        switch AppOptions.temperatureOption {
        case .standard:
            unit = "K"
        case .metric:
            unit = "°C"
        case .imperial:
            unit = "°F"
        }

        return unit
    }

    private var temperatureCurrentFormat: String {

        var format = ""

        switch AppOptions.temperatureOption {
        case .standard:
            format = "___.__"
        case .metric:
            format = "-__"
        case .imperial:
            format = "-__"
        }

        return format
    }

    private var windSpeedFormat: String {

        var format = ""

        switch AppOptions.windSpeedOption {
        case .ms:
            format = "__"
        case .kmh:
            format = "__"
        case .mph:
            format = "__"
        }

        return format
    }

    private var windUnitsLocalized: String {

        var units = ""

        switch AppOptions.windSpeedOption {
        case .ms:
            units = "m/s".localizedValue
        case .kmh:
            units = "km/h".localizedValue
        case .mph:
            units = "mph".localizedValue
        }

        return units
    }

    private var pressureUnitsLocalized: String {

        var units = ""

        switch AppOptions.pressureOption {
        case .hPa:
            units = "hPa".localizedValue
        case .mmHg:
            units = "mmHg".localizedValue
        case .mb:
            units = "mb".localizedValue
        }

        return units
    }

    private var distanceUnitsLocalized: String {

        var units = ""

        switch AppOptions.distanceOption {
        case .meter:
            units = "meter".localizedValue
        case .kilometre:
            units = "kilometre".localizedValue
        case .mile:
            units = "mile".localizedValue
        }

        return units
    }
}
