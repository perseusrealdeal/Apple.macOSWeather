//
//  CurrentSystemLanguageGift.swift
//  Gifts
//
//  Just a gift. Tested with Swift 4.2 compiler.
//  https://gist.github.com/perseusrealdeal/98b082b136d574dd1b5aa760036dac8b
//

/* Perseus Logger source code */
/* https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5 */

import Foundation

extension Locale {

    static var currentSystemLanguage: (language: String, region: String)? {

        guard
            let identifier = preferredLanguages.first
        else {
            log.message("[\(type(of: self))].\(#function), first", .error)
            return nil
        }

        guard
            let languageCode = Locale(identifier: identifier).languageCode
        else {
            log.message("[\(type(of: self))].\(#function), languageCode", .error)
            return nil
        }

        return (languageCode, Locale(identifier: identifier).regionCode ?? "")
    }
}
