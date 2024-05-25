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

    // MARK: - Init

    init(date: String, hours: [ForecastHour]) {
        self.date = date
        self.hours = hours
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

        let weekday = getWeekday()

        return weekday.isEmpty ? MeteoFactsDefaults.weekday : weekday
    }

    public var dateDayMonth: String {

        let forecastDate = getForecastDate()

        return forecastDate.isEmpty ? MeteoFactsDefaults.forecastDate : forecastDate
    }

    public var nightTemperature: String {

        let temperature = getNightTemperature()

        return temperature.isEmpty ? MeteoFactsDefaults.temperature : temperature
    }

    public var dayTemperature: String {

        let temperature = getDayTemperature()

        return temperature.isEmpty ? MeteoFactsDefaults.temperature : temperature
    }

    // MARK: - Realization

    private func getIconName() -> String {
        return ""
    }

    private func getConditions() -> String {
        return ""
    }

    private func getWeekday() -> String {
        return ""
    }

    private func getForecastDate() -> String {
        return ""
    }

    private func getNightTemperature() -> String {
        return ""
    }

    private func getDayTemperature() -> String {
        return ""
    }
}
