//
//  CurrentMeteoFacts.swift
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

import Foundation

// MARK: - Meteo facts from the data source just AS IS

public class CurrentMeteoFacts {

    public var meteoDataProviderName: String?

    public var weatherIconName: String?
    public var weatherDescription: String?

    public var temperature: String?
    public var temperatureFeelsLike: String?
    public var temperatureMinimum: String?
    public var temperatureMaximum: String?

    public var windSpeed: String?
    public var windGusts: String?
    public var windDirection: String?

    public var pressure: String?
    public var humidity: Int?
    public var visibility: Int?

    public var sunrise: Int?
    public var sunset: Int?

    public var lastOne: Int?
    public var timezone: Int?
}

extension CurrentMeteoFacts {

    public func removeAll() {

        meteoDataProviderName = nil

        weatherIconName = nil
        weatherDescription = nil

        temperature = nil
        temperatureFeelsLike = nil
        temperatureMinimum = nil
        temperatureMaximum = nil

        windSpeed = nil
        windGusts = nil
        windDirection = nil

        pressure = nil
        humidity = nil
        visibility = nil

        sunrise = nil
        sunset = nil

        lastOne = nil
        timezone = nil
    }
}
