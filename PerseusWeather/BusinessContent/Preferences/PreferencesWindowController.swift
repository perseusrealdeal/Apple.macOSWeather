//
//  PreferencesWindowController.swift, PreferencesWindowController.storyboard
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

class PreferencesWindowController: NSWindowController, NSWindowDelegate {

    deinit {
        log.message("[\(type(of: self))].deinit")
    }

    class func storyboardInstance() -> PreferencesWindowController {
        let sb = NSStoryboard(name: String(describing: self), bundle: nil)
        let screen = sb.instantiateInitialController() as? PreferencesWindowController

        // Do default setup; don't set any parameter causing loadWindow up, breaks unit tests.

        return screen ?? PreferencesWindowController()
    }

    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // window?.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        // if #available(macOS 10.14, *) { self.window?.title = "Settings..." }

        self.window?.title = screenTitle
    }

    // MARK: - Contract, public methods

    func windowShouldClose(_ sender: NSWindow) -> Bool {
        self.window?.orderOut(sender)
        return false
    }

    // MARK: Private variables

    private var screenTitle: String {
        let localizedBundleDisplayName =
            Bundle.main.localizedInfoDictionary?["CFBundleDisplayName"] as? String

        var calculatedTitle: String?

        if #available(macOS 10.14, *) {
            calculatedTitle = "settings"
        } else {
            calculatedTitle = "preferences"
        }

        if let left = localizedBundleDisplayName, let right = calculatedTitle {
            return "\(left) - \(right)"
        } else {
            return "Settings"
        }
    }

    // MARK: Realization, private methods

}
