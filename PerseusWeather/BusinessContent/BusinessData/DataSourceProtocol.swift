//
//  DataSourceProtocol.swift
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

public enum DataSourceProvider: CustomStringConvertible {
    public var description: String {
        switch self {
        case .serviceOpenWeatherMap:
            return "OpenWeather" // Market name.
        }
    }

    case serviceOpenWeatherMap // Version 2.5.
}

public protocol DataSourceProtocol {
    var dataSourceProvider: DataSourceProvider { get set }
}
