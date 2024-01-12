//
//  MeteoDataRepresenter.swift
//  PerseusMeteo
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
//  Special thanks for common convertion weather values formulas goes to Google Inc.
//  https://www.google.com/search?q=temperature+converter
//
// TODO: - Add the mention of Google Inc. to README.
//
// swiftlint:disable file_length
//

import Foundation

public func representTemperature(_ value: String,
                                 asIs: TemperatureOption,
                                 toBe: TemperatureOption) -> String {

    guard asIs != toBe, let temp = Double(value) else { return value }

    // Fahrenheit > Celsius
    if asIs == .imperial, toBe == .metric {

        // (0°F − 32) × 5/9
        let tempRecalculated = Int(((temp - 32) * 5/9).rounded())

        return tempRecalculated.description
    }

    // Fahrenheit > Kelvin
    if asIs == .imperial, toBe == .standard {

        // (0°F − 32) × 5/9 + 273.15
        let tempRecalculated = (temp - 32) * 5/9 + 273.15

        return tempRecalculated.cut(.two).description
    }

    return value
}

// Represents wind speed or gusts.
public func representWindSpeedGusts(_ value: String,
                                    asIs: WindSpeedOption,
                                    toBe: WindSpeedOption) -> String {

    guard asIs != toBe, let speed = Double(value) else { return value }

    // Meter per second [meter/sec] > Kilometer per hour [km/hour]
    if asIs == .ms, toBe == .kmh {

        // Multiply the speed value by 3.6
        let speedCalculated = (speed * 3.6).cut(.two)

        return speedCalculated.description
    }

    // Meter per second [meter/sec] > Mile per hour [mph]
    if asIs == .ms, toBe == .mph {

        // Multiply the speed value by 2.237
        let speedCalculated = (speed * 2.237).cut(.two)

        return speedCalculated.description
    }

    return value
}

// Represents pressure.
public func representPressure(_ value: String,
                              asIs: PressureOption,
                              toBe: PressureOption) -> String {

    guard asIs != toBe, let pressure = Double(value) else { return value }

    // Hectopascal [hPa] > Millibar [mbar]
    if asIs == .hPa, toBe == .mb {

        //  1 hPa = 1 mbar

        return value
    }

    // Hectopascal [hPa] > Millibar [mbar]
    if asIs == .hPa, toBe == .mmHg {

        // 1 hPa = 0.75 mmHg
        let pressureRecalculated = Int((pressure * 0.75).rounded())

        return pressureRecalculated.description
    }

    return value
}

// Represents distance.
public func representDistance(_ value: Int,
                              asIs: LengthOption,
                              toBe: LengthOption) -> String {

    guard asIs != toBe else { return value.description }

    // Meter [m] > Kilometre [km]
    if asIs == .meter, toBe == .kilometre {

        // distance = value / 1000
        let distance = (Double(value) / 1000).cut(.two)

        return distance.description
    }

    // Meter [m] > Mile [mi]
    if asIs == .meter, toBe == .mile {

        // distance = value / 1609
        let distance = (Double(value) / 1609).cut(.two)

        return distance.description
    }

    return value.description
}

// Represents a time of sunrise, sunset and other meteo times.
public func representMeteoTime(_ value: Int,
                               _ timezone: Int,
                               toBe: TimeFormatOption) -> String? {

    // Calculate required time format.
    let current = Date.currentTimeFormat
    let required = toBe == .system ? current : toBe == .hour12 ? .hour12 : .hour24

    // Create a date object of the given time and timezone.
    let date = Date(timeIntervalSince1970: TimeInterval(value))
    let dateInTimeZone = date.addingTimeInterval(TimeInterval(timezone))

    let time = dateInTimeZone.timeInFormat(required)

    return time
}

// Represents a last time of success API response calculation.
public func representLastOneCalculationTime(_ value: Int,
                                            _ timezone: Int,
                                            toBe: TimeFormatOption)
    -> (day: String?, time: String?) {

        // Calculate required time format.
        let current = Date.currentTimeFormat
        let required = toBe == .system ? current : toBe == .hour12 ? .hour12 : .hour24

        // Create a date object of the given time and timezone.
        let date = Date(timeIntervalSince1970: TimeInterval(value))

        // Time.
        let dateInTimeZone = date.addingTimeInterval(TimeInterval(timezone))
        let theTime = dateInTimeZone.timeInFormat(required, withSeconds: true)

        // Day.
        guard let timezone = TimeZone(secondsFromGMT: timezone) else { return (nil, nil) }

        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = timezone

        let components = calendar.dateComponents([.day, .month, .year], from: date)

        // Parse.
        guard
            let day = components.day,
            let month = components.month,
            let year = components.year else { return (nil, nil) }

        // Formate.

        // let dayCalculated = required == .hour24 ? day.inTime : day.description
        let yearMark = "Year mark".localizedValue
        let theDay = "\(day) \(monthNames[month-1].localizedValue) \(year)\(yearMark)"

        return (theDay, theTime)
}

// Represents Icon for current weather from OpenWeatherMap service.
public func representOpenWeatherMapIcon(_ id: Int, _ icon: String) -> String {

    // TODO: - Recalculate weather Icon name.

    return "Icon"
}

public let monthNames = // 12 elements
    ["January",
     "February",
     "March",
     "April",
     "May",
     "June",
     "Jule",
     "August",
     "September",
     "October",
     "November",
     "December"]
