//
//  OpenWeatherCurrentRefresher.swift
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
// swiftlint:disable file_length
//

import Foundation

public class OpenWeatherCurrentRefresher: CurrentWeatherRefresherProtocol {

    private var meteoFacts: CurrentMeteoFacts!

    public func refresh(object: CurrentMeteoFacts, _ source: [String: Any]) {

        guard source.isEmpty == false else {
            object.removeAll()
            return
        }

        meteoFacts = object

        // Make a notice what data source used...
        meteoFacts.meteoDataProviderName =
            MeteoProvider.serviceOpenWeatherMap.description

        // Update weather conditions, Icon and short description.
        updateWeatherConditions(from: source)

        // Update temperatures.
        updateTemperatures(from: source)

        // Update pressure.
        updatePressure(from: source)

        // Update humidity.
        updateHumidity(from: source)

        // Update visibility.
        updateVisibility(from: source)

        // Update wind.
        updateWind(from: source)

        // Update timezone.
        updateTimezone(from: source)

        // Update sunrize, and sunset.
        updateSunriseSunset(from: source)

        // Update last time calculated.
        updateLastOne(from: source)
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

                    meteoFacts.weatherIconName = iconName
                    meteoFacts.weatherDescription = description
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

                meteoFacts.temperature = temp.description
                meteoFacts.temperatureFeelsLike = feels_like.description
                meteoFacts.temperatureMinimum = temp_min.description
                meteoFacts.temperatureMaximum = temp_max.description
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

                meteoFacts.pressure = value.description

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

                meteoFacts.humidity = value

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

            meteoFacts.visibility = visibility
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

                meteoFacts.windSpeed = speed.description
                meteoFacts.windGusts = gust.description
                meteoFacts.windDirection = deg.description
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

            meteoFacts.timezone = timezone
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

                meteoFacts.sunrise = rise
                meteoFacts.sunset = set
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

            meteoFacts.lastOne = dt
        } else {
            log.message("[\(type(of: self))].\(#function) dt wrong.", .error)
        }
    }
}
