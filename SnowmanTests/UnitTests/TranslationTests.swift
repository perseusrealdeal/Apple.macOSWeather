//
//  TranslationTests.swift
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
// swiftlint:disable file_length
//

import XCTest
@testable import Snowman

class TranslationTests: XCTestCase {

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }
    // func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    // MARK: - Popover Screen

    func test_translation_of_PopoverScreen() {

        // assert

        XCTAssertEqual("Button: Call Weather".localizedExpectation,
                       "Button: Call Weather".localizedValue)

        XCTAssertEqual("Button: Call Forecast".localizedExpectation,
                       "Button: Call Forecast".localizedValue)

        XCTAssertEqual("Label: Made with Love".localizedExpectation,
                       "Label: Made with Love".localizedValue)

        XCTAssertEqual("Tab: Current Weather".localizedExpectation,
                       "Tab: Current Weather".localizedValue)

        XCTAssertEqual("Tab: Forecast".localizedExpectation,
                       "Tab: Forecast".localizedValue)

        XCTAssertEqual("Button: Quit".localizedExpectation,
                       "Button: Quit".localizedValue)

        XCTAssertEqual("Button: About".localizedExpectation,
                       "Button: About".localizedValue)

        XCTAssertEqual("Button: Options".localizedExpectation,
                       "Button: Options".localizedValue)

        XCTAssertEqual("Button: Hide".localizedExpectation,
                       "Button: Hide".localizedValue)
    }

    // MARK: - LocationView

    func test_translation_of_PopoverScreen_LocationView() {

        // assert

        XCTAssertEqual("Label: Permission".localizedExpectation,
                       "Label: Permission".localizedValue)

        XCTAssertEqual("GeoAccess: .notDetermined".localizedExpectation,
                       "GeoAccess: .notDetermined".localizedValue)

        XCTAssertEqual("GeoAccess: .deniedForAllAndRestricted".localizedExpectation,
                       "GeoAccess: .deniedForAllAndRestricted".localizedValue)

        XCTAssertEqual("GeoAccess: .restricted".localizedExpectation,
                       "GeoAccess: .restricted".localizedValue)

        XCTAssertEqual("GeoAccess: .deniedForAllApps".localizedExpectation,
                       "GeoAccess: .deniedForAllApps".localizedValue)

        XCTAssertEqual("GeoAccess: .deniedForTheApp".localizedExpectation,
                       "GeoAccess: .deniedForTheApp".localizedValue)

        XCTAssertEqual("GeoAccess: .allowed".localizedExpectation,
                       "GeoAccess: .allowed".localizedValue)

        XCTAssertEqual("Geo Couple".localizedExpectation,
                       "Geo Couple".localizedValue)

        XCTAssertEqual("Button: Allow Geo...".localizedExpectation,
                       "Button: Allow Geo...".localizedValue)

        XCTAssertEqual("Button: Go to Settings...".localizedExpectation,
                       "Button: Go to Settings...".localizedValue)

        XCTAssertEqual("Button: Refresh Current Location".localizedExpectation,
                       "Button: Refresh Current Location".localizedValue)

    }

    // MARK: - WeatherView

    func test_translation_of_PopoverScreen_WeatherView() {

        // assert

        XCTAssertEqual("Label: Meteo Data Provider".localizedExpectation,
                       "Label: Meteo Data Provider".localizedValue)

        XCTAssertEqual("Label: About Current Weather".localizedExpectation,
                       "Label: About Current Weather".localizedValue)

        XCTAssertEqual("Prefix: Curren Weather in Brief".localizedExpectation,
                       "Prefix: Curren Weather in Brief".localizedValue)

        XCTAssertEqual("Prefix: Feels Like".localizedExpectation,
                       "Prefix: Feels Like".localizedValue)

        XCTAssertEqual("Prefix: Min".localizedExpectation,
                       "Prefix: Min".localizedValue)

        XCTAssertEqual("Prefix: Max".localizedExpectation,
                       "Prefix: Max".localizedValue)

        XCTAssertEqual("Prefix: Humidity".localizedExpectation,
                       "Prefix: Humidity".localizedValue)

        XCTAssertEqual("Prefix: Visibility".localizedExpectation,
                       "Prefix: Visibility".localizedValue)

        XCTAssertEqual("Unit: Meter".localizedExpectation,
                       "Unit: Meter".localizedValue)

        XCTAssertEqual("Unit: Kilometre".localizedExpectation,
                       "Unit: Kilometre".localizedValue)

        XCTAssertEqual("Unit: Mile".localizedExpectation,
                       "Unit: Mile".localizedValue)

        XCTAssertEqual("Unit: Foot".localizedExpectation,
                       "Unit: Foot".localizedValue)

        XCTAssertEqual("Label: Speed".localizedExpectation,
                       "Label: Speed".localizedValue)

        XCTAssertEqual("Label: Direction".localizedExpectation,
                       "Label: Direction".localizedValue)

        XCTAssertEqual("Label: Gust".localizedExpectation,
                       "Label: Gust".localizedValue)

        XCTAssertEqual("Unit: m/s".localizedExpectation,
                       "Unit: m/s".localizedValue)

        XCTAssertEqual("Unit: km/h".localizedExpectation,
                       "Unit: km/h".localizedValue)

        XCTAssertEqual("Unit: mph".localizedExpectation,
                       "Unit: mph".localizedValue)

        XCTAssertEqual("Label: Pressure".localizedExpectation,
                       "Label: Pressure".localizedValue)

        XCTAssertEqual("Unit: hPa".localizedExpectation,
                       "Unit: hPa".localizedValue)

        XCTAssertEqual("Unit: mmHg".localizedExpectation,
                       "Unit: mmHg".localizedValue)

        XCTAssertEqual("Unit: mb".localizedExpectation,
                       "Unit: mb".localizedValue)

        XCTAssertEqual("Label: Sunrise".localizedExpectation,
                       "Label: Sunrise".localizedValue)

        XCTAssertEqual("Label: Sunset".localizedExpectation,
                       "Label: Sunset".localizedValue)

        XCTAssertEqual("AM".localizedExpectation,
                       "AM".localizedValue)

        XCTAssertEqual("PM".localizedExpectation,
                       "PM".localizedValue)

        XCTAssertEqual("Postfix: Year".localizedExpectation,
                       "Postfix: Year".localizedValue)

        XCTAssertEqual("Prefix: Last One".localizedExpectation,
                       "Prefix: Last One".localizedValue)
    }

    // MARK: - ForecastView

    func test_translation_of_PopoverScreen_ForecastView() {

        // assert

        XCTAssertEqual("Label: Conditions".localizedExpectation,
                       "Label: Conditions".localizedValue)
        XCTAssertEqual("Label: Weekday short".localizedExpectation,
                       "Label: Weekday short".localizedValue)
        XCTAssertEqual("Label: Forecast Date".localizedExpectation,
                       "Label: Forecast Date".localizedValue)
    }

    // MARK: - Options Screen

    func test_translation_of_OptionsScreen() {

        // assert

        XCTAssertEqual("Title: Options Screen".localizedExpectation,
                       "Title: Options Screen".localizedValue)

        XCTAssertEqual("Section: App Options".localizedExpectation,
                       "Section: App Options".localizedValue)

        XCTAssertEqual("Option: Language".localizedExpectation,
                       "Option: Language".localizedValue)

        XCTAssertEqual("Option: OpenWeather Key".localizedExpectation,
                       "Option: OpenWeather Key".localizedValue)

        XCTAssertEqual("Option: Time Format".localizedExpectation,
                       "Option: Time Format".localizedValue)

        XCTAssertEqual("Section: Meteo Options".localizedExpectation,
                       "Section: Meteo Options".localizedValue)

        XCTAssertEqual("Option: Temperature".localizedExpectation,
                       "Option: Temperature".localizedValue)

        XCTAssertEqual("Option: Wind Speed".localizedExpectation,
                       "Option: Wind Speed".localizedValue)

        XCTAssertEqual("Option: Pressure".localizedExpectation,
                       "Option: Pressure".localizedValue)

        XCTAssertEqual("Option: Distance".localizedExpectation,
                       "Option: Distance".localizedValue)

        XCTAssertEqual("OpenWeather: Lock".localizedExpectation,
                       "OpenWeather: Lock".localizedValue)

        XCTAssertEqual("OpenWeather: Unlock".localizedExpectation,
                       "OpenWeather: Unlock".localizedValue)

        XCTAssertEqual("OpenWeather: Hidden".localizedExpectation,
                       "OpenWeather: Hidden".localizedValue)

        XCTAssertEqual("OpenWeather: Editable".localizedExpectation,
                       "OpenWeather: Editable".localizedValue)

        XCTAssertEqual("Unit: Light".localizedExpectation,
                       "Unit: Light".localizedValue)

        XCTAssertEqual("Unit: Dark".localizedExpectation,
                       "Unit: Dark".localizedValue)

        XCTAssertEqual("Unit: System".localizedExpectation,
                       "Unit: System".localizedValue)

        XCTAssertEqual("Unit: English".localizedExpectation,
                       "Unit: English".localizedValue)

        XCTAssertEqual("Unit: Russian".localizedExpectation,
                       "Unit: Russian".localizedValue)

        XCTAssertEqual("Unit: 24-hour".localizedExpectation,
                       "Unit: 24-hour".localizedValue)

        XCTAssertEqual("Unit: 12-hour".localizedExpectation,
                       "Unit: 12-hour".localizedValue)

        XCTAssertEqual("Unit: Kelvin".localizedExpectation,
                       "Unit: Kelvin".localizedValue)

        XCTAssertEqual("Unit: Celsius".localizedExpectation,
                       "Unit: Celsius".localizedValue)

        XCTAssertEqual("Unit: Fahrenheit".localizedExpectation,
                       "Unit: Fahrenheit".localizedValue)

        XCTAssertEqual("Unit: m/s long".localizedExpectation,
                       "Unit: m/s long".localizedValue)

        XCTAssertEqual("Unit: km/h long".localizedExpectation,
                       "Unit: km/h long".localizedValue)

        XCTAssertEqual("Unit: mph long".localizedExpectation,
                       "Unit: mph long".localizedValue)

        XCTAssertEqual("Unit: Kilometre long".localizedExpectation,
                       "Unit: Kilometre long".localizedValue)

        XCTAssertEqual("Unit: Mile long".localizedExpectation,
                       "Unit: Mile long".localizedValue)

        XCTAssertEqual("Button: Close".localizedExpectation,
                       "Button: Close".localizedValue)
    }

    // MARK: - Compass Directions

    func test_translation_of_Compass_Directions() {

        // assert

        XCTAssertEqual("Compass: N".localizedExpectation, "Compass: N".localizedValue)
        XCTAssertEqual("Compass: NNE".localizedExpectation, "Compass: NNE".localizedValue)
        XCTAssertEqual("Compass: NE".localizedExpectation, "Compass: NE".localizedValue)
        XCTAssertEqual("Compass: ENE".localizedExpectation, "Compass: ENE".localizedValue)
        XCTAssertEqual("Compass: E".localizedExpectation, "Compass: E".localizedValue)
        XCTAssertEqual("Compass: ESE".localizedExpectation, "Compass: ESE".localizedValue)
        XCTAssertEqual("Compass: SE".localizedExpectation, "Compass: SE".localizedValue)
        XCTAssertEqual("Compass: SSE".localizedExpectation, "Compass: SSE".localizedValue)
        XCTAssertEqual("Compass: S".localizedExpectation, "Compass: S".localizedValue)
        XCTAssertEqual("Compass: SSW".localizedExpectation, "Compass: SSW".localizedValue)
        XCTAssertEqual("Compass: SW".localizedExpectation, "Compass: SW".localizedValue)
        XCTAssertEqual("Compass: WSW".localizedExpectation, "Compass: WSW".localizedValue)
        XCTAssertEqual("Compass: W".localizedExpectation, "Compass: W".localizedValue)
        XCTAssertEqual("Compass: WNW".localizedExpectation, "Compass: WNW".localizedValue)
        XCTAssertEqual("Compass: NW".localizedExpectation, "Compass: NW".localizedValue)
        XCTAssertEqual("Compass: NNW".localizedExpectation, "Compass: NNW".localizedValue)
    }

    // MARK: - Months

    func test_translation_of_Compass_Months() {

        // assert

        XCTAssertEqual("Month: December".localizedExpectation,
                       "Month: December".localizedValue)
        XCTAssertEqual("Month: January".localizedExpectation,
                       "Month: January".localizedValue)
        XCTAssertEqual("Month: February".localizedExpectation,
                       "Month: February".localizedValue)
        XCTAssertEqual("Month: March".localizedExpectation,
                       "Month: March".localizedValue)
        XCTAssertEqual("Month: April".localizedExpectation,
                       "Month: April".localizedValue)
        XCTAssertEqual("Month: May".localizedExpectation,
                       "Month: May".localizedValue)
        XCTAssertEqual("Month: June".localizedExpectation,
                       "Month: June".localizedValue)
        XCTAssertEqual("Month: Jule".localizedExpectation,
                       "Month: Jule".localizedValue)
        XCTAssertEqual("Month: August".localizedExpectation,
                       "Month: August".localizedValue)
        XCTAssertEqual("Month: September".localizedExpectation,
                       "Month: September".localizedValue)
        XCTAssertEqual("Month: October".localizedExpectation,
                       "Month: October".localizedValue)
        XCTAssertEqual("Month: November".localizedExpectation,
                       "Month: November".localizedValue)
    }

    // MARK: - About Screen

    func test_translation_of_AboutScreen() {

        // assert

        XCTAssertEqual("Button: The App Source Code".localizedExpectation,
                       "Button: The App Source Code".localizedValue)
        XCTAssertEqual("Button: The Technological Tree".localizedExpectation,
                       "Button: The Technological Tree".localizedValue)
        XCTAssertEqual("Label: The App Version".localizedExpectation,
                       "Label: The App Version".localizedValue)
        XCTAssertEqual("Label: Star Copyright Notice".localizedExpectation,
                       "Label: Star Copyright Notice".localizedValue)
        XCTAssertEqual("Label: Copyright Details".localizedExpectation,
                       "Label: Copyright Details".localizedValue)
        XCTAssertEqual("Label: Credits".localizedExpectation,
                       "Label: Credits".localizedValue)
        XCTAssertEqual("Label: Balancing and Control".localizedExpectation,
                       "Label: Balancing and Control".localizedValue)
        XCTAssertEqual("Label: Writing".localizedExpectation,
                       "Label: Writing".localizedValue)
        XCTAssertEqual("Label: Documenting".localizedExpectation,
                       "Label: Documenting".localizedValue)
        XCTAssertEqual("Label: Artworking".localizedExpectation,
                       "Label: Artworking".localizedValue)
        XCTAssertEqual("Label: EN Expectation".localizedExpectation,
                       "Label: EN Expectation".localizedValue)
        XCTAssertEqual("Label: RU Expectation".localizedExpectation,
                       "Label: RU Expectation".localizedValue)
        XCTAssertEqual("Label: Author".localizedExpectation,
                       "Label: Author".localizedValue)
        XCTAssertEqual("Button: License".localizedExpectation,
                       "Button: License".localizedValue)
        XCTAssertEqual("Button: Terms & Conditions".localizedExpectation,
                       "Button: Terms & Conditions".localizedValue)
    }
}
