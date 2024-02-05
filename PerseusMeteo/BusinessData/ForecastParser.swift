//
//  ForecastParser.swift
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

// MARK: - Weather App values ready for reading, viewing on a screen

public class ForecastParser: JsonDataDictionary, MeteoProviderProtocol {

    // MARK: - Meteo facts and refresher

    private var meteoFacts: ForecastMeteoFacts = ForecastMeteoFacts()
    private var refresher: ForecastRefresherProtocol = OpenWeatherForecastRefresher()

    // MARK: - Meteo data provider

    public var providerMeteoData: MeteoProvider = .serviceOpenWeatherMap {
        didSet {
            switch providerMeteoData {
            case .serviceOpenWeatherMap:
                refresher = OpenWeatherForecastRefresher()
            }

            log.message("[\(type(of: self))].\(#function)")
        }
    }

    // MARK: - Load meteo facts from source

    public func refresh() {

        guard let json = json else { return }

        switch providerMeteoData {
        case .serviceOpenWeatherMap:
            refresher.refresh(object: meteoFacts, json)
        }
    }

    // MARK: - Loaded meteo data ready for reading, viewing on a screen

    public var meteoDataProviderName: String {

        guard let value = meteoFacts.meteoDataProviderName else {
            return ForecastMeteoFacts.meteoDataProviderNameDefault
        }

        return value
    }

    public var lastOne: String { // Last time API request response.
        return ForecastMeteoFacts.lastOneDefault
    }

}
