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

import Foundation

protocol OptionTemperatureChanged {
    func optionTemperatureDidChanged()
}

extension Notification.Name {
    public static let optionTemperatureDidChanged =
        Notification.Name("optionTemperatureDidChanged")
}

public enum TemperatureOption: Int, CustomStringConvertible {

    case standard = 0
    case metric   = 1
    case imperial = 2

    public var description: String {
        switch self {
        case .standard:
            return "Standard"
        case .metric:
            return "Metric"
        case .imperial:
            return "Imperial"
        }
    }

    public var value: String {
        switch self {
        case .standard:
            return "Kelvin"
        case .metric:
            return "Celsius"
        case .imperial:
            return "Fahrenheit"
        }
    }
}
