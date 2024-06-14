//
//  ForecastHour.swift
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

/* OpenWeatherMap JSON forecast hour sample in case if cnt = 1

{
   "clouds":{
      "all":100
   },
   "wind":{
      "speed":10.42,
      "deg":210,
      "gust":21.030000000000001
   },
   "dt":1708884000,
   "snow":{
      "3h":0.69999999999999996
   },
   "dt_txt":"2024-02-25 18:00:00",
   "main":{
      "humidity":96,
      "feels_like":-6.54,
      "temp_min":6.0599999999999996,
      "temp_max":6.0599999999999996,
      "temp":6.0599999999999996,
      "pressure":1040,
      "temp_kf":0,
      "sea_level":1040,
      "grnd_level":1021
   },
   "weather":[
      {
         "id":600,
         "main":"Snow",
         "icon":"13n",
         "description":"light snow"
      }
   ],
   "pop":0.48999999999999999,
   "sys":{
      "pod":"n"
   },
   "visibility":130
}

*/

public var count = 0

public struct ForecastHour {

    public var label: String // For debug purpose

    // MARK: - Data

    private var source = [String: Any]()
    private var timezone = 0

    // MARK: - Init

    init(title: String) {
        self.label = title
    }

    init(source: [String: Any], timezone: Int, title: String = "") {
        self.init(title: title)

        self.source = source
        self.timezone = timezone
    }

    // MARK: - Contract

    // MARK: - Time of Hour

    public var time: String {

        let time = getTime()

        return time.isEmpty ? MeteoFactsDefaults.sunrizesunset : time
    }

    // MARK: - Temperature

    public var temperature: String {

        let temperature = getTemperature()

        return temperature.isEmpty ? MeteoFactsDefaults.temperature : temperature
    }

    // MARK: - Incoming Precipitation

    public var weatherConditions: String {

        let conditions = getConditions()

        return conditions.isEmpty ? MeteoFactsDefaults.conditions : conditions
    }

    // MARK: - Public calculations

    public func getMeteoGroupData() -> MeteoGroupData {

        count += 1

        log.message("- GET GROUP COUNT: \(count)")

        // Set titles up

        var meteogroup = MeteoGroupData()

        // Array 1

        meteogroup.title1 = "Prefix: Min".localizedValue + ", " + "Prefix: Max".localizedValue
        meteogroup.title2 = "Prefix: Feels Like".localizedValue
        meteogroup.title3 = "Prefix: Visibility".localizedValue

        // Array 2

        meteogroup.title4 = "Label: Speed".localizedValue
        meteogroup.title5 = "Label: Direction".localizedValue
        meteogroup.title6 = "Label: Gust".localizedValue

        // Array 3

        meteogroup.title7 = "Label: Pressure".localizedValue
        meteogroup.title8 = "Prefix: Humidity".localizedValue

        // TODO: - Add cloudiness

        // meteogroup.title9 = "Prefix: Cloudiness".localizedValue

        // Set values up

    // let valueMinMax = "\(dataSource.temperatureMinimum) : \(dataSource.temperatureMaximum)"

        // Array 1

        // meteogroup.value1 = valueMinMax
        // meteogroup.value2 = dataSource.temperatureFeelsLike
        // meteogroup.value3 = dataSource.visibility

        // Array 2

        // meteogroup.value4 = dataSource.windSpeed
        // meteogroup.value5 = dataSource.windDirection
        // meteogroup.value6 = dataSource.windGusts

        // Array 3

        // meteogroup.value7 = dataSource.pressure
        // meteogroup.value8 = dataSource.humidity

        // TODO: - Add cloudiness

        // meteogroup.value9 = dataSource.cloudiness

        return meteogroup
    }

    // MARK: - Realization

    private func getTime() -> String {
        return ""
    }

    private func getTemperature() -> String {
        return ""
    }

    private func getConditions() -> String {
        return ""
    }
}
