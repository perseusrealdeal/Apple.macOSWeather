//
//  OpenWeatherStarModels.swift
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

extension Notification.Name {
    public static let meteoDataOptionsDidChanged =
        Notification.Name("meteoDataOptionsDidChanged")
}

// MARK: - TEMPERATURE

public enum TemperatureOption: Int, CustomStringConvertible {

    case standard = 0
    case metric   = 1
    case imperial = 2

    public var description: String {
        return "\(systemType): \(systemValue)"
    }

    public var systemValue: String {
        switch self {
        case .standard:
            return "Kelvin"
        case .metric:
            return "Celsius"
        case .imperial:
            return "Fahrenheit"
        }
    }

    public var systemType: String {
        switch self {
        case .standard:
            return "Standard"
        case .metric:
            return "Metric"
        case .imperial:
            return "Imperial"
        }
    }

    public var unit: String {
        switch self {
        case .standard:
            return  "K"
        case .metric:
            return  "°C"
        case .imperial:
            return  "°F"
        }
    }
}

// MARK: - WIND SPEED

public enum WindSpeedOption: Int, CustomStringConvertible {

    case ms  = 0
    case kmh = 1
    case mph = 2

    public var description: String {
        return "\(systemType): \(systemValue)"
    }

    public var systemValue: String {
        switch self {
        case .ms:
            return "meter/sec"
        case .kmh:
            return "km/hour"
        case .mph:
            return "miles/hour"
        }
    }

    public var systemType: String {
        switch self {
        case .ms:
            return "Metric"
        case .kmh:
            return "Metric"
        case .mph:
            return "Imperial"
        }
    }

    public var unitLocalized: String {
        switch self {
        case .ms:
            return "Unit: m/s".localizedValue
        case .kmh:
            return "Unit: km/h".localizedValue
        case .mph:
            return "Unit: mph".localizedValue
        }
    }
}

// MARK: - PRESSURE

public enum PressureOption: Int, CustomStringConvertible {

    case hPa  = 0
    case mmHg = 1
    case mb   = 2

    public var description: String {
        return "\(systemValue)"
    }

    public var systemValue: String {
        switch self {
        case .hPa:
            return "hPa"
        case .mmHg:
            return "mmHg"
        case .mb:
            return "mb" // Millibars.
        }
    }

    public var unitLocalized: String {
        switch self {
        case .hPa:
            return "Unit: hPa".localizedValue
        case .mmHg:
            return "Unit: mmHg".localizedValue
        case .mb:
            return "Unit: mb".localizedValue
        }
    }
}

// MARK: - LENGTH

public enum LengthOption: Int, CustomStringConvertible {

    case meter     = 0
    case kilometre = 1
    case mile      = 2

    public var description: String {

        var unit = ""

        switch self {
        case .meter:
            unit = "meter"
        case .kilometre:
            unit = "kilometre"
        case .mile:
            unit = "mile"
        }

        return unit
    }

    public var unitLocalized: String {
        switch self {
        case .meter:
            return "Unit: Meter".localizedValue
        case .kilometre:
            return "Unit: Kilometre".localizedValue
        case .mile:
            return "Unit: Mile".localizedValue
        }
    }
}

// MARK: - TIME FORMATS

// Used to represent and store end-user choice
public enum TimeFormatOption: Int, CustomStringConvertible {

    case hour24 = 0
    case hour12 = 1
    case system = 2

    public var description: String {
        return "\(systemValue)"
    }

    public var systemValue: String {
        switch self {
        case .hour24:
            return "24-hour"
        case .hour12:
            return "12-hour"
        case .system:
            return "system-hour"
        }
    }
}

public let compassDirections = // 17 elements
    ["N",
     "N/NE",
     "NE",
     "E/NE",
     "E",
     "E/SE",
     "SE",
     "S/SE",
     "S",
     "S/SW",
     "SW",
     "W/SW",
     "W",
     "W/NW",
     "NW",
     "N/NW",
     "N"]
