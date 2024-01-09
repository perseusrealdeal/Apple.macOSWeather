//
//  OpenWeatherMapRefresher.swift
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
// swiftlint:disable file_length
//

import Foundation

extension MeteoDataParser {

    // MARK: - Realization, start method for OpenWeatherMap

    internal func updateFromOpenWeatherMap(_ source: [String: Any]) {
        guard !source.isEmpty else { return }

        // Make a notice what data source used...
        meteoDataProviderNameCalculated = dataSourceProvider.description

        let dictionary = source

        // Update weather conditions, Icon and short description.
        updateWeatherConditions(from: dictionary)

        // Update temperatures.
        updateTemperatures(from: dictionary)

        // Update pressure.
        updatePressure(from: dictionary)

        // Update humidity.
        updateHumidity(from: dictionary)

        // Update visibility.
        updateVisibility(from: dictionary)

        // Update wind.
        updateWind(from: dictionary)

        // Update timezone.
        updateTimezone(from: dictionary)

        // Update sunrize, and sunset.
        updateSunriseSunset(from: dictionary)

        // Update last time calculated.
        updateLastOne(from: dictionary)
    }

    // MARK: - Updating weather values

    private func updateWeatherConditions(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let weather = dictionary["weather"] as? [Any] {
            if let wFirst = weather.first as? [String: Any] {
                if let id = wFirst["id"] as? Int,
                    let icon = wFirst["icon"] as? String,
                    let description = wFirst["description"] as? String {

                    let iconName = representOpenWeatherMapIcon(id, icon)

                    weatherIconNameCalculated = iconName
                    weatherDescriptionCalculated = description
                } else {
                    log.message("[\(type(of: self))].\(#function) Attribute wrong.", .error)
                }
            } else {
                log.message("[\(type(of: self))].\(#function) Weather first wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Weather wrong.", .error)
        }
    }

    private func updateTemperatures(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let main = dictionary["main"] as? [String: Any] {
            if let temp = main["temp"] as? Double,
                let feels_like = main["feels_like"] as? Double,
                let temp_min = main["temp_min"] as? Double,
                let temp_max = main["temp_max"] as? Double {

                temperatureCalculated = temp.description
                temperatureFeelsLikeCalculated = feels_like.description
                temperatureMinimumCalculated = temp_min.description
                temperatureMaximumCalculated = temp_max.description
            } else {
                log.message("[\(type(of: self))].\(#function) Attribute wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Main wrong.", .error)
        }
    }

    private func updatePressure(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let main = dictionary["main"] as? [String: Any] {
            if let value = main["pressure"] as? Int {

                pressureCalculated = value.description

            } else {
                log.message("[\(type(of: self))].\(#function) Attribute wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Main wrong.", .error)
        }
    }

    private func updateHumidity(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let main = dictionary["main"] as? [String: Any] {
            if let value = main["humidity"] as? Int {

                humidityCalculated = value

            } else {
                log.message("[\(type(of: self))].\(#function) Humidity wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Main wrong.", .error)
        }
    }

    private func updateVisibility(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let visibility = dictionary["visibility"] as? Int {

            visibilityCalculated = visibility
        } else {
            log.message("[\(type(of: self))].\(#function) Visibility wrong.", .error)
        }
    }

    private func updateWind(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let wind = dictionary["wind"] as? [String: Any] {
            if let speed = wind["speed"] as? Double,
                let gust = wind["gust"] as? Double,
                let deg = wind["deg"] as? Int {

                windSpeedCalculated = speed.description
                windGustsCalculated = gust.description
                windDirectionCalculated = deg.description
            } else {
                log.message("[\(type(of: self))].\(#function) Attribute wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Wind wrong.", .error)
        }
    }

    private func updateTimezone(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        // Timezone.

        if let timezone = dictionary["timezone"] as? Int {

            timezoneCalculated = timezone
        } else {
            log.message("[\(type(of: self))].\(#function) Timezone wrong.", .error)
        }
    }

    private func updateSunriseSunset(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        // Sunrise and sunset.

        if let sys = dictionary["sys"] as? [String: Any] {
            if let rise = sys["sunrise"] as? Int,
                let set = sys["sunset"] as? Int {

                sunriseCalculated = rise
                sunsetCalculated = set
            } else {
                log.message("[\(type(of: self))].\(#function) Attribute wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) Sys wrong.", .error)
        }
    }

    private func updateLastOne(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        // Timezone.

        if let dt = dictionary["dt"] as? Int {

            lastOneCalculated = dt
        } else {
            log.message("[\(type(of: self))].\(#function) dt wrong.", .error)
        }
    }

}
