//
//  CurrentWeatherParser.swift
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

public class CurrentWeatherParser: JsonDataDictionary, MeteoProviderProtocol {

    // MARK: - Meteo facts and refresher

    private var meteoFacts: CurrentMeteoFacts = CurrentMeteoFacts()
    private var refresher: CurrentWeatherRefresherProtocol = OpenWeatherCurrentRefresher()

    // MARK: - Meteo data provider

    public var providerMeteoData: MeteoProvider = .serviceOpenWeatherMap {
        didSet {
            switch providerMeteoData {
            case .serviceOpenWeatherMap:
                refresher = OpenWeatherCurrentRefresher()
            }

            log.message("[\(type(of: self))].\(#function)")
        }
    }

    // MARK: - Load meteo facts from source

    public func refresh() {

        guard let json = json else { return }

        switch providerMeteoData {
        case .serviceOpenWeatherMap:
            refresher.refresh(object: meteoFacts, json)
        }
    }

    // MARK: - Loaded meteo data ready for reading, viewing on a screen

    public var meteoDataProviderName: String {

        guard let value = meteoFacts.meteoDataProviderName else {
            return CurrentMeteoFacts.meteoDataProviderNameDefault
        }

        return value
    }

    public var lastOne: String { // Last time API request response.

        guard
            let value = meteoFacts.lastOne,
            let timezone = meteoFacts.timezone
        else {
            return CurrentMeteoFacts.lastOneDefault
        }

        let lastOne = representLastOneCalculationTime(value,
                                                      timezone,
                                                      toBe: AppOptions.timeFormatOption)
        let prefix = "Prefix: Last One".localizedValue
        let postfixYear = "Postfix: Year".localizedValue

        let day = lastOne.day == nil ? "" : "\(lastOne.day ?? "")\(postfixYear) "

        return "\(prefix): \(day)\(lastOne.time ?? CurrentMeteoFacts.lastOneDefault)"
    }

    public var weatherIconName: String {

        guard
            let value = meteoFacts.weatherIconName
        else {
            return CurrentMeteoFacts.weatherIconNameDefault
        }

        return value
    }

    public var weatherDescription: String {

        guard
            let value = meteoFacts.weatherDescription
        else {
            return CurrentMeteoFacts.weatherDescriptionDefault
        }

        return "Prefix: Curren Weather in Brief".localizedValue + ": \(value)"
    }

    public var temperature: String {

        guard
            let value = meteoFacts.temperature
        else {
            return CurrentMeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(CurrentMeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureFeelsLike: String {

        guard
            let value = meteoFacts.temperatureFeelsLike
        else {
            return CurrentMeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(CurrentMeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureMinimum: String {

        guard
            let value = meteoFacts.temperatureMinimum
        else {
            return CurrentMeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(CurrentMeteoFacts.temperatureCurrentUnit)"
    }

    public var temperatureMaximum: String {

        guard
            let value = meteoFacts.temperatureMaximum
        else {
            return CurrentMeteoFacts.temperatureDefault
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(CurrentMeteoFacts.temperatureCurrentUnit)"
    }

    public var windSpeed: String {

        guard
            let value = meteoFacts.windSpeed
        else {
            return CurrentMeteoFacts.windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(CurrentMeteoFacts.windUnitsLocalized)"
    }

    public var windGusts: String {

        guard
            let value = meteoFacts.windGusts
        else {
            return CurrentMeteoFacts.windSpeedDefault
        }

        // Recalculate if needed.
        let represented = representWindSpeedGusts(value,
                                        asIs: WindSpeedOption.ms,
                                        toBe: AppOptions.windSpeedOption)

        return "\(represented) \(CurrentMeteoFacts.windUnitsLocalized)"
    }

    public var windDirection: String {

        guard
            let value = meteoFacts.windDirection,
            let point = try? WindDegree(value)
        else {
            return CurrentMeteoFacts.windDirectionDefault
        }

        return "\(Int(point.degree))°: \(point.common.abbreviation.localizedValue)"
    }

    public var pressure: String {

        guard
            let value = meteoFacts.pressure
        else {
            return CurrentMeteoFacts.pressureDefault
        }

        // Recalculate if needed.
        let represented = representPressure(value,
                                            asIs: PressureOption.hPa,
                                            toBe: AppOptions.pressureOption)

        return "\(represented) \(CurrentMeteoFacts.pressureUnitsLocalized)"
    }

    public var humidity: String {

        guard
            let value = meteoFacts.humidity
        else {
            return CurrentMeteoFacts.humidityDefault
        }

        return "\(value) %"
    }

    public var visibility: String {

        guard
            let value = meteoFacts.visibility
        else {
            return CurrentMeteoFacts.visibilityDefault
        }

        // Recalculate if needed.
        let represented = representDistance(value,
                                            asIs: LengthOption.meter,
                                            toBe: AppOptions.distanceOption)

        return "\(represented) \(CurrentMeteoFacts.distanceUnitsLocalized)"
    }

    public var sunrise: String {

        guard
            let value = meteoFacts.sunrise,
            let timezone = meteoFacts.timezone
        else {
            return CurrentMeteoFacts.sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? CurrentMeteoFacts.sunrizeSunsetDefault)"
    }

    public var sunset: String {

        guard
            let value = meteoFacts.sunset,
            let timezone = meteoFacts.timezone
        else {
            return CurrentMeteoFacts.sunrizeSunsetDefault
        }

        // Recalculate if needed.
        let represented = representMeteoTime(value,
                                             timezone,
                                             toBe: AppOptions.timeFormatOption)

        return "\(represented ?? CurrentMeteoFacts.sunrizeSunsetDefault)"
    }
}
