//
//  TheMenu.swift, MainMenu.xib
//  PerseusWeather
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//  Copyright © PerseusRealDeal.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Cocoa

class TheMenu: NSMenu {

    @IBOutlet private weak var settingsMenuItem: NSMenuItem! {
        didSet {
            if #available(macOS 10.14, *) {
                settingsMenuItem.title = "Settings..."
            }
        }
    }
}
