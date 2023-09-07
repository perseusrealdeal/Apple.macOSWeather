//
//  PreferencesVC.swift
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

class PreferencesViewController: NSViewController {

    @IBOutlet weak var segmentedControl: NSSegmentedControl!

    @IBAction func segmentedControlValueChanged(_ sender: NSSegmentedControl) {
        changeDarkModeValue(selected: sender.selectedSegment)
    }

    let darkModeObserver = DarkModeObserver()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.preferredContentSize = NSSize(width: self.view.frame.size.width,
                                           height: self.view.frame.size.height)

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        self.parent?.view.window?.title = self.title!
        updateDarkModeOption()
    }

    private func updateDarkModeOption() {
        switch AppearanceService.DarkModeUserChoice {
        case .auto:
            segmentedControl.selectedSegment = 2
        case .on:
            segmentedControl.selectedSegment = 1
        case .off:
            segmentedControl.selectedSegment = 0
        }
    }

    private func changeDarkModeValue(selected: Int) {
        switch selected {
        case 0:
            changeDarkModeManually(.off)
        case 1:
            changeDarkModeManually(.on)
        case 2:
            changeDarkModeManually(.auto)
        default:
            break
        }
    }

    private func callDarkModeSensitiveColours() {
        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }
}
