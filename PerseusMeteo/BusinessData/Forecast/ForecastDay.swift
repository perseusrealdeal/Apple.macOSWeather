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

public struct ForecastDay {

    public var label = ""

    public var forecastHours: [ForecastHour] {

        var days = [ForecastHour]()

        for item in 0...24 {
            days.append(ForecastHour(label: item.description))
        }

        return days
    }
}
