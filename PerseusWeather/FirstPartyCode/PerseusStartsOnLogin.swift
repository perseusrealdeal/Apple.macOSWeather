//
//  PerseusStartsOnLogin.swift
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

public enum PerseusStartsOnLoginError: Error, CustomStringConvertible {

    case castError
    case urlError

    public var description: String {
        switch self {
        case .castError:
            return "Type casting error took a place."
        case .urlError:
            return "There's a problem to get the path of the app."
        }
    }

    public var logMessage: String {
        return "[\(type(of: self))].\(#function) - \(self)"
    }
}

public enum StartsOnLoginOption: Int, CustomStringConvertible {

    case on  = 1
    case off = 0

    public var description: String {
        switch self {
        case .on:
            return "On"
        case .off:
            return "Off"
        }
    }
}

class PerseusStartsOnLogin {

    static var startsOnLoginItems: LSSharedFileList? {
        return LSSharedFileListCreate(nil,
                                      kLSSharedFileListSessionLoginItems.takeUnretainedValue(),
                                      nil)?.takeRetainedValue()
    }

    static func registration(option: StartsOnLoginOption) throws {
        guard let isTurnedOn = Bool(exactly: NSNumber(value: option.rawValue)) else {
            throw PerseusStartsOnLoginError.castError
        }

        if isTurnedOn {
            enable()
        } else {
            disable()
        }
    }

    static func isTurnedOn() throws -> Bool {
        log.message("[\(type(of: self))].\(#function)")

        guard
            let items = startsOnLoginItems,
            let list = LSSharedFileListCopySnapshot(items, nil)?.takeRetainedValue()
                as? [LSSharedFileListItem]
        else {
            throw PerseusStartsOnLoginError.castError
        }

        for item in list {
            var error: Unmanaged<CFError>?
            let appUrl = LSSharedFileListItemCopyResolvedURL(item,
                                                              0,
                                                              &error)?.takeRetainedValue()

            if let gotError = error?.takeRetainedValue() {
                log.message(gotError.localizedDescription, .error)
                continue
            }

            guard let url = appUrl, let path = (url as NSURL).path else {
                log.message("[\(type(of: self))].\(#function) - urlError", .error)
                throw PerseusStartsOnLoginError.urlError
            }

            if path.contains(Bundle.main.bundlePath) {
                log.message("[\(type(of: self))].\(#function) - \(path)")
                return true
            }
        }
        log.message("[\(type(of: self))].\(#function) - \(false)")
        return false
    }

    private static func enable() {
        log.message("[\(type(of: self))].\(#function)")

        guard let items = startsOnLoginItems else { return }

        LSSharedFileListInsertItemURL(items,
                                      kLSSharedFileListItemBeforeFirst.takeUnretainedValue(),
                                      nil,
                                      nil,
                                      Bundle.main.bundleURL as NSURL,
                                      nil,
                                      nil)
    }

    private static func disable() {
        log.message("\(#function) not supported.")
    }
}
