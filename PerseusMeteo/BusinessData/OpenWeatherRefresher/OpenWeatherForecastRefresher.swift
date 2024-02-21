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
        meteoFacts.meteoDataProviderName = "\(MeteoProvider.serviceOpenWeatherMap)"

        // Update timezone.
        updateTimezone(from: source)

        // Update forecast days.
        updateForecastDays(from: source)
    }

    // MARK: - Realization

    private func updateTimezone(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

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

    private func updateForecastDays(from dictionary: [String: Any]) {

        log.message("[\(type(of: self))].\(#function)")

        if let list = dictionary["list"] as? [Any], let timezone = meteoFacts.timezone {

            let daysSorted = createForecastDays(from: list, timezone: timezone)
            var forecastDays = [ForecastDay]()

            for item in daysSorted {

                // let addition = "DAY KEY: \(item.key) : count \(item.value.count)"
                // log.message("[\(type(of: self))].\(#function) \(addition)")

                let hours = createForecastHours(from: item.value)

                forecastDays.append(ForecastDay(date: item.key, hours: hours))
            }

            meteoFacts.forecastDays = forecastDays

        } else {
            log.message("[\(type(of: self))].\(#function) city wrong.", .error)
        }
    }

    fileprivate func createForecastDays(from list: [Any], timezone: Int) ->
        [(key: String, value: [[String: Any]?])] {

            let listItems = list.map { $0 as? [String: Any] }

            var days = Dictionary(grouping: listItems, by: { (item) -> String in

                if let item = item, let dt = item["dt"] as? Int {

                    let day = Date(timeIntervalSince1970: TimeInterval(dt))
                    let formatter = DateFormatter()

                    formatter.dateStyle = .medium
                    formatter.timeStyle = .none
                    formatter.dateFormat = "yyyy-MM-dd"
                    formatter.timeZone = TimeZone(secondsFromGMT: timezone)

                    let theDay = formatter.string(from: day)

                    // log.message("[\(type(of: self))].\(#function) dt: \(theDay)")

                    return theDay

                } else {
                    log.message("[\(type(of: self))].\(#function) dt wrong.", .error)
                }

                return "-1"
            })

            days.removeValue(forKey: "-1")

            // log.message("[\(type(of: self))].\(#function) DAYS: \(days.count)")
            // log.message("[\(type(of: self))].\(#function) LIST ITEMS: \(listItems.count)")

            let daysSorted = days.sorted(by: {
                createDate(from: $0.key) < createDate(from: $1.key)
            })

            return daysSorted
    }

    fileprivate func createForecastHours(from source: [[String: Any]?]) -> [ForecastHour] {
        guard source.isEmpty == false else {
            return [ForecastHour]()
        }

        var hours = [ForecastHour]()

        for item in source {
            guard let item = item else {
                continue
            }

            hours.append(ForecastHour(source: item, title: "auto"))
        }

        return hours
    }

    fileprivate func createDate(from date: String, format: String = "yyyy-MM-dd") -> Date {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        let theDay = dateFormatter.date(from: date)!

        return theDay
    }
}
