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

class TheMenu: NSMenu {

    @IBOutlet private weak var menu: NSMenu!
    @IBOutlet private weak var customViewMenuItem: NSMenuItem!
    @IBOutlet private weak var settingsMenuItem: NSMenuItem! {
        didSet {
            if #available(macOS 10.14, *) {
                settingsMenuItem.title = "Settings..."
            }
        }
    }

    var theMenu: NSMenu {
        return menu
    }

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")
    }
}
