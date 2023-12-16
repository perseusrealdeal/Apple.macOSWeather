//
//  AboutWindowController.swift, AboutWindowController.storyboard
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

import Cocoa

class AboutWindowController: NSWindowController {

    deinit {
        log.message("[\(type(of: self))].deinit")
    }

    class func storyboardInstance() -> AboutWindowController {
        let sb = NSStoryboard(name: String(describing: self), bundle: nil)
        let screen = sb.instantiateInitialController() as? AboutWindowController

        // Do default setup; don't set any parameter causing loadWindow up, breaks unit tests.

        return screen ?? AboutWindowController()
    }

    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // window?.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        // if #available(macOS 10.14, *) { self.window?.title = "Settings..." }

        self.window?.title = ""
    }
}
