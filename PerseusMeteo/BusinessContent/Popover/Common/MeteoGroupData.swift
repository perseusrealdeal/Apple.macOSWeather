//
//  MeteoGroupData.swift
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

public struct MeteoGroupData {

    public var title1: String = "-- / --"
    public var title2: String = "-- / --"
    public var title3: String = "-- / --"
    public var title4: String = "-- / --"
    public var title5: String = "-- / --"
    public var title6: String = "-- / --"
    public var title7: String = "-- / --"
    public var title8: String = "-- / --"
    public var title9: String = "-- / --"

    public var value1: String = "Default: N/A".localizedValue
    public var value2: String = "Default: N/A".localizedValue
    public var value3: String = "Default: N/A".localizedValue
    public var value4: String = "Default: N/A".localizedValue
    public var value5: String = "Default: N/A".localizedValue
    public var value6: String = "Default: N/A".localizedValue
    public var value7: String = "Default: N/A".localizedValue
    public var value8: String = "Default: N/A".localizedValue
    public var value9: String = "Default: N/A".localizedValue
}

public func setupMeteoGroupTitles(group: MeteoGroupData) -> MeteoGroupData {

    var group = group

    // Array 1

    group.title1 = "Prefix: Min".localizedValue + ", " + "Prefix: Max".localizedValue
    group.title2 = "Prefix: Feels Like".localizedValue
    group.title3 = "Prefix: Visibility".localizedValue

    // Array 2

    group.title4 = "Label: Speed".localizedValue
    group.title5 = "Label: Direction".localizedValue
    group.title6 = "Label: Gust".localizedValue

    // Array 3

    group.title7 = "Label: Pressure".localizedValue
    group.title8 = "Prefix: Humidity".localizedValue

    // TODO: - Add cloudiness

    // group.title9 = "Prefix: Cloudiness".localizedValue

    return group
}
