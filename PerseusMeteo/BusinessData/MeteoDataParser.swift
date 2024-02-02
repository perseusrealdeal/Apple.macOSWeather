//
//  MeteoDataParser.swift
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

import Foundation

// MARK: - Weather App values ready for reading, viewing on a screen

public class MeteoDataParser: JsonDataDictionary, MeteoDataSourceProtocol {

    // MARK: - Meteo facts and refresher

    private var meteoFacts: MeteoFacts = MeteoFacts()
    private var refresher: MeteoDataRefresherProtocol = OpenWeatherRefresher()

    // MARK: - Meteo data provider

    public var meteoDataProvider: MeteoDataProvider = .serviceOpenWeatherMap {
        didSet {
            switch meteoDataProvider {
            case .serviceOpenWeatherMap:
                refresher = OpenWeatherRefresher()
            }
            log.message("[\(type(of: self))].\(#function)")
        }
    }

    // MARK: - Load meteo facts from source

    public func refresh() {

        guard let json = json else { return }

        switch meteoDataProvider {
        case .serviceOpenWeatherMap:
            refresher.refresh(object: meteoFacts, json)
        }
    }

    // MARK: - Loaded meteo data ready for reading, viewing on a screen

    public var lastOne: String { // Last time API request response.

        guard
            let value = meteoFacts.lastOne,
            let timezone = meteoFacts.timezone
        else {
            return MeteoFacts.lastOneDefault
        }

        let lastOne = representLastOneCalculationTime(value,
                                                      timezone,
                                                      toBe: AppOptions.timeFormatOption)
        let prefix = "Prefix: Last One".localizedValue
        let postfixYear = "Postfix: Year".localizedValue

        let day = lastOne.day == nil ? "" : "\(lastOne.day ?? "")\(postfixYear) "

        return "\(prefix): \(day)\(lastOne.time ?? MeteoFacts.lastOneDefault)"
    }

    public var meteoDataProviderName: String {

        guard
            let value = meteoFacts.meteoDataProviderName
        else {
            return MeteoFacts.meteoDataProviderNameDefault
        }

        return value
    }

    public var weatherIconName: String {

        guard
            let value = meteoFacts.weatherIconName
        else {
            return MeteoFacts.weatherIconNameDefault
        }

        return value
    }

    public var weatherDescription: String {

        guard
            let value = meteoFacts.weatherDescription
        else {
            return MeteoFacts.weatherDescriptionDefault
        }

        return "Prefix: Curren Weather in Brief".localizedValue + ": \(value)"
    }

    public var temperature: String {

        guard
            let value = meteoFacts.temperature
        else {
            return MeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(MeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureFeelsLike: String {

        guard
            let value = meteoFacts.temperatureFeelsLike
        else {
            return MeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(MeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureMinimum: String {

        guard
            let value = meteoFacts.temperatureMinimum
        else {
            return MeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(MeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureMaximum: String {

        guard
            let value = meteoFacts.temperatureMaximum
        else {
            return MeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(MeteoFacts.temperatureCurrentUnit)"
    }

    public var windSpeed: String {

        guard
            let value = meteoFacts.windSpeed
        else {
            return MeteoFacts.windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(MeteoFacts.windUnitsLocalized)"
    }

    public var windGusts: String {

        guard
            let value = meteoFacts.windGusts
        else {
            return MeteoFacts.windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(MeteoFacts.windUnitsLocalized)"
    }

    public var windDirection: String {

        guard
            let value = meteoFacts.windDirection,
            let point = try? WindDegree(value)
        else {
            return MeteoFacts.windDirectionDefault
        }

        return "\(Int(point.degree))°: \(point.common.abbreviation.localizedValue)"
    }

    public var pressure: String {

        guard
            let value = meteoFacts.pressure
        else {
            return MeteoFacts.pressureDefault
        }

        // Recalculate if needed.
        let represented = representPressure(value,
                                            asIs: PressureOption.hPa,
                                            toBe: AppOptions.pressureOption)

        return "\(represented) \(MeteoFacts.pressureUnitsLocalized)"
    }

    public var humidity: String {

        guard
            let value = meteoFacts.humidity
        else {
            return MeteoFacts.humidityDefault
        }

        return "\(value) %"
    }

    public var visibility: String {

        guard
            let value = meteoFacts.visibility
        else {
            return MeteoFacts.visibilityDefault
        }

        // Recalculate if needed.
        let represented = representDistance(value,
                                            asIs: LengthOption.meter,
                                            toBe: AppOptions.distanceOption)

        return "\(represented) \(MeteoFacts.distanceUnitsLocalized)"
    }

    public var sunrise: String {

        guard
            let value = meteoFacts.sunrise,
            let timezone = meteoFacts.timezone
        else {
            return MeteoFacts.sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? MeteoFacts.sunrizeSunsetDefault)"
    }

    public var sunset: String {

        guard
            let value = meteoFacts.sunset,
            let timezone = meteoFacts.timezone
        else {
            return MeteoFacts.sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? MeteoFacts.sunrizeSunsetDefault)"
    }
}
