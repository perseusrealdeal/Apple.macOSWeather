//
//  CurrentMeteoFactsDefaults.swift
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

extension CurrentMeteoFacts {

    public static var meteoDataProviderNameDefault: String {
        return AppGlobals.meteoProviderName
    }

    public static var lastOneDefault: String {
        return "Label: Made with Love".localizedValue
    }

    public static var weatherIconNameDefault: String {
        return AppGlobals.statusMenusButtonIconName
    }

    public static var weatherDescriptionDefault: String {
        return "Label: About Current Weather".localizedValue
    }

    public static var temperatureDefault: String {
        return "\(temperatureCurrentFormat) \(temperatureCurrentUnit)"
    }

    public static var windSpeedDefault: String {
        return "\(windSpeedFormat) \(windUnitsLocalized)"
    }

    public static var windDirectionDefault: String {
        return  "___°: _/__"
    }

    public static var pressureDefault: String {
        return  "____ \(pressureUnitsLocalized)"
    }

    public static var humidityDefault: String {
        return  "___ %"
    }

    public static var visibilityDefault: String {
        return  "_____ \(distanceUnitsLocalized)"
    }

    public static var sunrizeSunsetDefault: String {

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

    public static var temperatureCurrentUnit: String {

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

    private static var temperatureCurrentFormat: String {

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

    private static var windSpeedFormat: String {

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

    public static var windUnitsLocalized: String {

        var units = ""

        switch AppOptions.windSpeedOption {
        case .ms:
            units = "Unit: m/s".localizedValue
        case .kmh:
            units = "Unit: km/h".localizedValue
        case .mph:
            units = "Unit: mph".localizedValue
        }

        return units
    }

    public static var pressureUnitsLocalized: String {

        var units = ""

        switch AppOptions.pressureOption {
        case .hPa:
            units = "Unit: hPa".localizedValue
        case .mmHg:
            units = "Unit: mmHg".localizedValue
        case .mb:
            units = "Unit: mb".localizedValue
        }

        return units
    }

    public static var distanceUnitsLocalized: String {

        var units = ""

        switch AppOptions.distanceOption {
        case .meter:
            units = "Unit: Meter".localizedValue
        case .kilometre:
            units = "Unit: Kilometre".localizedValue
        case .mile:
            units = "Unit: Mile".localizedValue
        }

        return units
    }
}
