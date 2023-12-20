//
//  TheMenu.swift, MainMenu.xib
//  PerseusWeather
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7531 - 7532 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import Cocoa

class TheMenu: NSMenu, Localizable {

    // MARK: - Outlets

    @IBOutlet private weak var menu: NSMenu!

    @IBOutlet private weak var locationViewMenuItem: NSMenuItem!
    @IBOutlet private weak var customViewMenuItem: NSMenuItem!

    @IBOutlet private weak var aboutMenuItem: NSMenuItem!
    @IBOutlet private weak var settingsMenuItem: NSMenuItem!
    @IBOutlet private weak var quitMenuItem: NSMenuItem!

    // MARK: - Actions

    @IBAction func showPreferences(_ sender: NSMenuItem) {
        globals.preferencesPresenter.showWindow(sender)
    }

    @IBAction func showAbout(_ sender: NSMenuItem) {
        globals.aboutPresenter.showWindow(sender)
    }
    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")

        let nc = AppGlobals.notificationCenter
        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)
    }

    // MARK: - Public variables

    var pullDownMenu: NSMenu {
        return menu
    }

    var locationMenuItem: NSMenuItem {
        return locationViewMenuItem
    }

    var weatherMenuItem: NSMenuItem {
        return customViewMenuItem
    }

    // MARK: - Contract, public methods

    @objc func localize() {
        aboutMenuItem.title = "About Menu Item".localizedValue
        settingsMenuItem.title = "Settings Menu Item".localizedValue
        quitMenuItem.title = "Quit Menu Item".localizedValue
    }
}

/*

 if #available(macOS 10.14, *) {
 settingsMenuItem.title = "Settings..."
 }

 */
