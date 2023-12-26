//
//  OptionsWindowController.swift, OptionsWindowController.storyboard
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

class OptionsWindowController: NSWindowController, NSWindowDelegate {

    // MARK: - Storyboard instance

    class func storyboardInstance() -> NSWindowController {

        log.message("[\(type(of: self))].\(#function)")

        let sb = NSStoryboard(name: String(describing: self), bundle: nil)

        guard let screen = sb.instantiateInitialController() as? NSWindowController else {
            let text = "NSWindowController went wrong to be created from the storyboard."
            log.message(text, .error); fatalError(text)
        }

        // Do default setup; don't set any parameter causing loadWindow up, breaks unit tests.

        return screen
    }

    // MARK: - Initialization

    override func awakeFromNib() {

        log.message("[\(type(of: self))].\(#function)")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        self.window?.title = "Options Screen Window Title".localizedValue
    }

    // MARK: - Other methods

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.window?.orderOut(sender)
        return false
    }
}
