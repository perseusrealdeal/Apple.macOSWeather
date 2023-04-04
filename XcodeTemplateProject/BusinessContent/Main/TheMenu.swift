//
//  TheMenu.swift, MainMenu.xib
//  XcodeTemplateProject
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
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
