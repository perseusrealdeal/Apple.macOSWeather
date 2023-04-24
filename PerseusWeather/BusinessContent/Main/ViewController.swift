//
//  ViewController.swift
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

class ViewController: NSViewController {

    deinit { log.message("\(type(of: self)).deinit") }

    @IBOutlet private(set) weak var greetingsLabel: NSTextField!

    @IBAction func buttonTapped(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function)")
        try? AppGlobals.locationDealer.askForCurrentLocation()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.wantsLayer = true

        AppearanceService.register(stakeholder: self, selector: #selector(makeUp))
        localizeContent()
    }

    @objc private func makeUp() {
        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")

        greetingsLabel.textColor = .perseusYellow
        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }

    private func localizeContent() {
        // NSLocale.currentLocaleDidChangeNotification
        greetingsLabel.cell?.title = "greetings".localizedValue
    }
}
