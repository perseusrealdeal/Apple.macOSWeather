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

public class OpenWeatherForecastParser: ForecastParserProtocol {

    public func getTimeZone(from dictionary: [String: Any]) -> Int? {

        // log.message("[\(type(of: self))].\(#function)")

        if let city = dictionary["city"] as? [String: Any] {
            if let timezone = city["timezone"] as? Int {

                // log.message("[\(type(of: self))].\(#function): \(timezone)")

                return timezone

            } else {
                log.message("[\(type(of: self))].\(#function) timezone wrong.", .error)
            }
        } else {
            log.message("[\(type(of: self))].\(#function) city wrong.", .error)
        }

        return nil
    }

    public func getForecastDays(from dictionary: [String: Any]) -> [ForecastDay]? {

        // log.message("[\(type(of: self))].\(#function)")

        guard
            let list = dictionary["list"] as? [Any],
            let timezone = getTimeZone(from: dictionary)
        else {

            log.message("[\(type(of: self))].\(#function) list wrong.", .error)

            return nil
        }

        let daysSorted = createForecastDays(from: list, timezone: timezone)
        var forecastDays = [ForecastDay]()

        for item in daysSorted {

            // let addition = "DAY KEY: \(item.key) : count \(item.value.count)"
            // log.message("[\(type(of: self))].\(#function) \(addition)")

            let hours = createForecastHours(from: item.value, timezone)

            forecastDays.append(ForecastDay(date: item.key, hours: hours))
        }

        // log.message("[\(type(of: self))].\(#function): \(forecastDays)")

        return forecastDays
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

    fileprivate func createForecastHours(from source: [[String: Any]?],
                                         _ timezone: Int = 0) -> [ForecastHour] {
        guard source.isEmpty == false else {
            return [ForecastHour]()
        }

        var hours = [ForecastHour]()

        for item in source {
            guard let item = item else {
                continue
            }

            hours.append(ForecastHour(source: item, timezone: timezone, title: "auto"))
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
