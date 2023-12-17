//
//  AppSettings.swift
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

import Foundation

// MARK: - Keys

// public let OPEN_WEATHER_API_KEY_OPTION_KEY = "OPEN_WEATHER_API_OPTION_KEY"
public let OPEN_WEATHER_API_KEY_TEXT_LIMIT = 77

public let LANGUAGE_OPTION_KEY = "LANGUAGE_OPTION_KEY"
public let LANGUAGE_OPTION_DEFAULT = LanguageOption.system

public let TEMPERATURE_OPTION_KEY = "TEMPERATURE_OPTION_KEY"
public let TEMPERATURE_OPTION_DEFAULT = TemperatureOption.metric

public let STARTSONLOGIN_OPTION_KEY = "STARTSONLOGIN_OPTION_KEY"
public let STARTSONLOGIN_OPTION_DEFAULT = StartsOnLoginOption.off

// MARK: - Service for keeping options saved

class AppSettings {

    public static var OpenWeatherAPIOption: String? {
        get {
            // Secret
            let defender = globals.dataDefender
            var secret: String?

            // Load value from Keychain
            do {
                secret = try defender.load(OpenWeatherCredentials())
            } catch DataDefenderError.unhandledError {
                return nil // Rejected to load a value
            } catch {
                return "" // There's no value
            }

            // TODO: check secret before returning value

            // The value should meet OPEN_WEATHER_API_KEY_TEXT_LIMIT

            // Saved value
            return secret
        }
        set {
            let value = newValue ?? ""

            // Update secret value
            let defender = globals.dataDefender
            let credentials = OpenWeatherCredentials(secret: value)

            if value.isEmpty {
                // Remove secret
                try? defender.remove(credentials)
            } else {
                // Save secret
                try? defender.save(credentials)
            }
        }
    }

    public static var languageOption: LanguageOption {
        get {
            // Load enum Int value

            let ud = AppGlobals.userDefaults

            let rawValue = ud.valueExists(forKey: LANGUAGE_OPTION_KEY) ?
                ud.integer(forKey: LANGUAGE_OPTION_KEY) : LANGUAGE_OPTION_DEFAULT.rawValue

            // Try to cast Int value to enum

            if let result = LanguageOption.init(rawValue: rawValue) { return result }

            // Return default saved value in any other case

            ud.setValue(LANGUAGE_OPTION_DEFAULT.rawValue, forKey: LANGUAGE_OPTION_KEY)
            return LANGUAGE_OPTION_DEFAULT
        }
        set {
            let ud = AppGlobals.userDefaults
            ud.setValue(newValue.rawValue, forKey: LANGUAGE_OPTION_KEY)
        }
    }

    public static var temperatureOption: TemperatureOption {
        get {
            // Load enum Int value

            let ud = AppGlobals.userDefaults

            let rawValue = ud.valueExists(forKey: TEMPERATURE_OPTION_KEY) ?
                ud.integer(forKey: TEMPERATURE_OPTION_KEY) :
                    TEMPERATURE_OPTION_DEFAULT.rawValue

            // Try to cast Int value to enum

            if let result = TemperatureOption.init(rawValue: rawValue) { return result }

            // Return default saved value in any other case

            ud.setValue(TEMPERATURE_OPTION_DEFAULT.rawValue, forKey: TEMPERATURE_OPTION_KEY)
            return TEMPERATURE_OPTION_DEFAULT
        }
        set {
            let ud = AppGlobals.userDefaults
            ud.setValue(newValue.rawValue, forKey: TEMPERATURE_OPTION_KEY)
        }
    }

    public static var startsOnLoginOption: StartsOnLoginOption {
        get {
            // Load enum Int value

            let ud = AppGlobals.userDefaults

            let rawValue = ud.valueExists(forKey: STARTSONLOGIN_OPTION_KEY) ?
                ud.integer(forKey: STARTSONLOGIN_OPTION_KEY) :
                STARTSONLOGIN_OPTION_DEFAULT.rawValue

            // Try to cast Int value to enum

            if let result = StartsOnLoginOption.init(rawValue: rawValue) { return result }

            // Return default saved value in any other case

            ud.setValue(STARTSONLOGIN_OPTION_DEFAULT.rawValue,
                        forKey: STARTSONLOGIN_OPTION_KEY)
            return STARTSONLOGIN_OPTION_DEFAULT
        }
        set {
            let ud = AppGlobals.userDefaults
            ud.setValue(newValue.rawValue, forKey: STARTSONLOGIN_OPTION_KEY)
        }
    }
}
