//
//  OpenMeteoCurrentRefresher.swift
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

public class OpenMeteoCurrentRefresher: CurrentWeatherRefresherProtocol {

    private var meteoFacts: CurrentMeteoFacts!

    public func refresh(object: CurrentMeteoFacts, _ source: [String: Any]) {

        guard source.isEmpty == false else {
            object.removeAll()
            return
        }

        meteoFacts = object

        // MARK: - Refresh meteo facts from OpenMeteo source here.
    }
}
