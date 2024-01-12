//
//  LanguageSwitcher.swift
//  PerseusMeteo
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

class LanguageSwitcher: NSObject {

    public static let shared: LanguageSwitcher = { return LanguageSwitcher() }()

    private override init() {
        super.init()

        // System language got changed: NSCurrentLocaleDidChangeNotification

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(languageChangedHandler(_:)),
            name: NSLocale.currentLocaleDidChangeNotification,
            object: nil
        )
    }

    @objc private func languageChangedHandler(_ notification: Notification) {
        log.message("[\(type(of: self))].\(#function)")

        // Relaunch the app

        guard let bundleID = Bundle.main.bundleIdentifier else { return }

        Process.launchedProcess(launchPath: "/usr/bin/open", arguments: ["-b", bundleID])
        app.terminate(self)
    }

    public var languageCalculated: String {

        var language = ""

        if AppOptions.languageOption == .system {
            if let preferedLang = NSLocale.preferredLanguages.first?.prefix(2),
               ["en", "ru"].contains(String(preferedLang)) {
                language = String(preferedLang)
            } else {
                language = "en"
            }
        } else {
            language = AppOptions.languageOption.string
        }

        return language
    }

    public func switchLanguageIfNeeded(_ currentUserChoice: LanguageOption) {

        var switchToLanguage = ""

        // Get the current language chosen by user
        if currentUserChoice == .system {
            if let preferedLang = NSLocale.preferredLanguages.first?.prefix(2),
                ["en", "ru"].contains(String(preferedLang)) {
                switchToLanguage = String(preferedLang)
            } else {
                switchToLanguage = "en"
            }
        } else {
            switchToLanguage = currentUserChoice == .en ? "en" : "ru"
        }

        let switching = "\(currentUserChoice.string) > \(switchToLanguage)"
        log.message("[\(type(of: self))].\(#function) - \(switching)")

        // Update bundle for selected language
        guard let path = Bundle.main.path(forResource: switchToLanguage, ofType: "lproj")
        else { return }

        String.bundle = Bundle.init(path: path)

        // Refresh localization
        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .languageSwitchedManuallyNotification))
    }
}
