//
//  PopoverLocalizationTests.swift
//  SnowmanTests
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

import XCTest
@testable import Snowman

class PopoverScreenLocalizationTests: XCTestCase {

    private var sut: PopoverViewController!

    override func setUp() {
        super.setUp()

        sut = PopoverViewController.storyboardInstance()
    }

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }
    // func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    func test_Localization_of_Popover() {

        // arrange

        sut.loadView()

        // assert

        XCTAssertEqual(sut.buttonQuit.title,
                       "Button: Quit".localizedValue)

        XCTAssertEqual(sut.buttonFetchMeteoFacts.title,
                       "Button: Call Weather".localizedValue)

        XCTAssertEqual(sut.labelMadeWithLove.stringValue,
                       "Label: Made with Love".localizedValue)

        XCTAssertEqual(sut.tabCurrentWeather.label,
                       "Tab: Current Weather".localizedValue)

        XCTAssertEqual(sut.tabForecast.label,
                       "Tab: Forecast".localizedValue)

        XCTAssertEqual(sut.buttonAbout.title,
                       "Button: About".localizedValue)

        XCTAssertEqual(sut.buttonOptions.title,
                       "Button: Options".localizedValue)

        XCTAssertEqual(sut.buttonHideAppScreens.title,
                       "Button: Hide".localizedValue)
    }

    func test_Localization_of_LocationView() {

        // arrange

        sut.loadView()

        // assert

        XCTAssertEqual(sut.viewLocation.labelLocationNameValue.stringValue,
                       "Greetings".localizedValue)

        XCTAssertEqual(sut.viewLocation.labelGeoCoupleDataValue.stringValue,
                       "Geo Couple".localizedValue)

        XCTAssertEqual(sut.viewLocation.labelPermissionTitle.stringValue,
                       "Label: Permission".localizedValue + ":")

        let permit = sut.viewLocation.refreshedForPermit

        XCTAssertEqual(sut.viewLocation.labelPermissionValue.stringValue,
                       permit?.permissionLocalKey.localizedValue)

        XCTAssertEqual(sut.viewLocation.buttonRefresh.title,
                       permit?.refreshLocalKey.localizedValue)
    }

    func test_Localization_of_WeatherView() {

        // arrange

        sut.loadView()

        // assert

        XCTAssertEqual(sut.viewCurrentWeather.labelMeteoProviderTitle.stringValue,
                       "Label: Meteo Data Provider".localizedValue)

        XCTAssertEqual(sut.viewCurrentWeather.labelMeteoProviderValue.stringValue,
                       MeteoFactsDefaults.meteoDataProviderName)

        XCTAssertEqual(sut.viewCurrentWeather.labelWeatherConditionValue.stringValue,
                       "Label: About Current Weather".localizedValue)

        let hum = "Prefix: Humidity".localizedValue + ": \(MeteoFactsDefaults.humidity)"
        XCTAssertEqual(sut.viewCurrentWeather.labelHumidity.stringValue, hum)

        let minmaxtitle = "Prefix: Min".localizedValue + ", " + "Prefix: Max".localizedValue
        XCTAssertEqual(sut.viewCurrentWeather.titleMinMaxTemperature.stringValue, minmaxtitle)

        let minmax =
            "\(MeteoFactsDefaults.temperature)" + " / " + "\(MeteoFactsDefaults.temperature)"
        XCTAssertEqual(sut.viewCurrentWeather.valueMinMaxTemperature.stringValue, minmax)

        let fltitle = "Prefix: Feels Like".localizedValue
        XCTAssertEqual(sut.viewCurrentWeather.titleFeelsLike.stringValue, fltitle)

        let fl = MeteoFactsDefaults.temperature
        XCTAssertEqual(sut.viewCurrentWeather.valueFeelsLike.stringValue, fl)

        let vistitle = "Prefix: Visibility".localizedValue
        XCTAssertEqual(sut.viewCurrentWeather.titleVisibility.stringValue, vistitle)

        let vis = MeteoFactsDefaults.visibility
        XCTAssertEqual(sut.viewCurrentWeather.valueVisibility.stringValue, vis)

        XCTAssertEqual(sut.viewCurrentWeather.labelWindSpeedTitle.stringValue,
                       "Label: Speed".localizedValue)
        XCTAssertEqual(sut.viewCurrentWeather.labelWindDirectionTitle.stringValue,
                       "Label: Direction".localizedValue)
        XCTAssertEqual(sut.viewCurrentWeather.labelWindGustsTitle.stringValue,
                       "Label: Gust".localizedValue)

        XCTAssertEqual(sut.viewCurrentWeather.labelWindSpeedValue.stringValue,
                       MeteoFactsDefaults.windSpeed)

        XCTAssertEqual(sut.viewCurrentWeather.labelWindDirectionValue.stringValue,
                       MeteoFactsDefaults.windDirection)

        XCTAssertEqual(sut.viewCurrentWeather.labelWindGustsValue.stringValue,
                       MeteoFactsDefaults.windSpeed)

        XCTAssertEqual(sut.viewCurrentWeather.labelPressureTitle.stringValue,
                       "Label: Pressure".localizedValue)

        XCTAssertEqual(sut.viewCurrentWeather.labelPressureValue.stringValue,
                       MeteoFactsDefaults.pressure)

        XCTAssertEqual(sut.viewCurrentWeather.labelSunriseTitle.stringValue,
                       "Label: Sunrise".localizedValue)

        XCTAssertEqual(sut.viewCurrentWeather.labelSunsetTitle.stringValue,
                       "Label: Sunset".localizedValue)

    }

    func test_Localization_of_ForecastView() {

        // arrange

        sut.loadView()

        // assert

        XCTAssertEqual(sut.viewForecast.labelMeteoProviderTitle.stringValue,
                       "Label: Meteo Data Provider".localizedValue)
    }
}
