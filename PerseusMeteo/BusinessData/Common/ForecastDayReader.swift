//
//  ForecastDayReader.swift
//  PerseusMeteo
//
//  Created by Mikhail Zhigulin on 01.03.2024.
//  Copyright © 2024 Mikhail Zhigulin. All rights reserved.
//

import Foundation

public class ForecastDayReader: ForecastDayDataReader {

    public var provider: MeteoProvider = .serviceOpenWeatherMap

    public var dayString: String = ""

}
