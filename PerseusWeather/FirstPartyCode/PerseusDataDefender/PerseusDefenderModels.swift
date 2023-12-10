//
//  PerseusDefenderModels.swift
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

public struct OpenWeatherCredentials {
    let note: String // = "Secured note"
    let service: String
    let account: String
    let description: String

    init(secret: String = "",
         service: String = "Open Weather Service",
         account: String = "perseusrealdeal",
         description: String = "API Key") {

        self.note = secret
        self.service = service
        self.account = account
        self.description = description
    }
}

extension OpenWeatherCredentials: KeychainQueryable {
    public var keychainQuery: [String: Any] {
        var query: [String: Any] = [:]

        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        query[String(kSecAttrAccount)] = account
        query[String(kSecAttrDescription)] = description

        return query
    }

    public var keychainLoadQuery: [String: Any] {
        var query: [String: Any] = [:]

        query[String(kSecClass)] = kSecClassGenericPassword
        query[String(kSecAttrService)] = service
        query[String(kSecAttrAccount)] = account
        query[String(kSecAttrDescription)] = description

        query[String(kSecMatchLimit)] = kSecMatchLimitOne
        query[String(kSecReturnAttributes)] = kCFBooleanTrue
        query[String(kSecReturnData)] = kCFBooleanTrue

        return query
    }
}
