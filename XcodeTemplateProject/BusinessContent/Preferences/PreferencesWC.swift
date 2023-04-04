//
//  PreferencesWC.swift, Preferences.storyboard
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

class PreferencesWindowController: NSWindowController, NSWindowDelegate {

    override func windowDidLoad() {
        super.windowDidLoad()

        window?.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        if #available(macOS 10.14, *) { self.window?.title = "Settings..." }
    }

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.window?.orderOut(sender)
        return false
    }
}
