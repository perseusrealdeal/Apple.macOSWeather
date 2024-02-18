//
//  OpenWeatherForecastRefresher.swift
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

public class OpenWeatherForecastRefresher: ForecastRefresherProtocol {

    private var meteoFacts: ForecastMeteoFacts!

    // MARK: - Contract

    public func refresh(object: ForecastMeteoFacts, _ source: [String: Any]) {

        guard source.isEmpty == false else {
            object.removeAll()
            return
        }

        meteoFacts = object

        // Make a notice what data source used...
        meteoFacts.meteoDataProviderName =
            MeteoProvider.serviceOpenWeatherMap.description

        // Update timezone.
        updateTimezone(from: source)

    }

    // MARK: - Realization

    private func updateTimezone(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        // Timezone.

        if let city = dictionary["city"] as? [String: Any] {
            if let timezone = city["timezone"] as? Int {
                meteoFacts.timezone = timezone
            } else {
                log.message("[\(type(of: self))].\(#function) timezone wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) city wrong.", .error)
        }
    }
/*
     "city" : {
     "sunset" : 1708342809,
     "country" : "RU",
     "id" : 1496747,
     "coord" : {
     "lat" : 55.060000000000002,
     "lon" : 83
     },
     "population" : 1419007,
     "timezone" : 25200,
     "sunrise" : 1708307039,
     "name" : "Новосибирск"
     }
 */
}
