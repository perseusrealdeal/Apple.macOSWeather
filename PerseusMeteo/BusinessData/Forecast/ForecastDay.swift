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

    // MARK: - Data

    public let date: String // Formate: YYYY-MM-DD, it's uniq calculated value
    public let hours: [ForecastHour]

    // MARK: - Init

    // MARK: - Contract

    public var dateTitle: String {
        return ""
    }

    public var minDateTemperature: String {
        return ""
    }

    public var maxDateTemperature: String {
        return ""
    }
}
