//
//  ForecastMeteoFacts.swift
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

// MARK: - Meteo facts from the data source just AS IS

public class ForecastMeteoFacts {

    public var meteoDataProviderName: String?

    public var lastOne: Int?
    public var timezone: Int?
}

extension ForecastMeteoFacts {

    public func removeAll() {

        meteoDataProviderName = nil

        lastOne = nil
        timezone = nil
    }
}
