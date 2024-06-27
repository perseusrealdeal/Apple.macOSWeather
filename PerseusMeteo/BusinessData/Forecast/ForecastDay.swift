//
//  ForecastDay.swift
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

/* OpenWeatherMap JSON forecast list items sample

{
  "message" : 0,
  "cod" : "200",
  "cnt" : 1,
  "list" : [
    // Forecast hours ...
  ],
  "city" : {
    "sunset" : 1708775436,
    "country" : "RU",
    "id" : 1496747,
    "coord" : {
      "lat" : 55.060000000000002,
      "lon" : 83
    },
    "population" : 1419007,
    "timezone" : 25200,
    "sunrise" : 1708738346,
    "name" : "Novosibirsk"
  }
}

*/

public struct ForecastDay {

    public var label: String = "" // For debug purpose

    // MARK: - Data

    public let date: String // Formate: YYYY-MM-DD, it's uniq calculated value
    public let hours: [ForecastHour]

    private let temperatures: [Double]

    // MARK: - Init

    init(date: String, hours: [ForecastHour]) {
        self.date = date
        self.hours = hours

        // Get temperatures.
        var temperatures = [Double]()

        hours.forEach {

            // Get value.
            if let main = $0.source["main"] as? [String: Any] {
                if let temp_min = main["temp"] as? Double {

                    temperatures.append(temp_min)

                } else {
                    log.message("[\(#function) [temp] wrong.", .error)
                }
            } else {
                log.message("[\(#function) [main] wrong.", .error)
            }
        }

        self.temperatures = temperatures
    }

    // MARK: - Contract

    public var weatherConditionIconName: String {

        let iconName = getIconName()

        return iconName.isEmpty ? "Icon" : iconName
    }

    public var weatherConditions: String {

        let conditions = getConditions()

        return conditions.isEmpty ? MeteoFactsDefaults.conditions : conditions
    }

    public var dateDayOfTheWeek: String {

        guard
            let firstHour = hours.first,
            let dt = firstHour.source["dt"] as? Int,
            let theDayOfTheWeek = representLastOneCalculationTime(
                dt,
                firstHour.timezone,
                toBe: AppOptions.timeFormatOption).theDayOfTheWeek,
            let theDayOfTheWeekLocalized = DayOfTheWeek(rawValue: theDayOfTheWeek)?.localized
        else {
            return MeteoFactsDefaults.weekday
        }

        return theDayOfTheWeekLocalized
    }

    public var dateDayMonth: String {

        guard let firstHour = hours.first else { return MeteoFactsDefaults.forecastDate }

        let source = firstHour.source
        let tz = firstHour.timezone

        return getForecastDay(from: source, timezone: tz)
    }

    public var minimumTemperature: String {

        let temperature = temperatures.min()

        guard let value = temperature?.description else {
            return MeteoFactsDefaults.temperature
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(AppOptions.temperatureOption.unit)"
    }

    public var maximumTemperature: String {

        let temperature = temperatures.max()

        guard let value = temperature?.description else {
            return MeteoFactsDefaults.temperature
        }

        // Recalculate if needed.
        let represented = representTemperature(value,
                                               asIs: TemperatureOption.imperial,
                                               toBe: AppOptions.temperatureOption)

        return "\(represented) \(AppOptions.temperatureOption.unit)"
    }

    // MARK: - Realization

    private func getIconName() -> String {
        return ""
    }

    private func getConditions() -> String {
        return ""
    }
}
