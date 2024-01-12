//
//  AboutViewController.swift, AboutWindowController.storyboard
//  PerseusMeteo
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

class AboutViewController: NSViewController {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()

    // MARK: - Outlets

    @IBOutlet weak var theSourceCodeGitHubButton: NSButton!
    @IBOutlet weak var theAppleTechnologicalTreeButton: NSButton!

    @IBOutlet weak var theLicenseButton: NSButton!
    @IBOutlet weak var theTermsButton: NSButton!
    @IBOutlet weak var theCloseButton: NSButton!

    @IBOutlet weak var theAppNameText: NSTextField!

    @IBOutlet weak var theAppVersionLabel: NSTextField!
    @IBOutlet weak var theAppVertionText: NSTextField!

    @IBOutlet var theCopyrightText: NSTextView!
    @IBOutlet var theCopyrightDetailsText: NSTextView!

    @IBOutlet var theCreditsText: NSTextView!

    // MARK: - Actions

    @IBAction func closeButtonTapped(_ sender: NSButton) {

        globals.aboutPresenter.close()
    }

    @IBAction func licenseButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        // TODO: - Show licencse text for reading
    }

    @IBAction func termsButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        // TODO: - Show terms and conditions text for reading
    }

    // MARK: - Other Actions

    @IBAction func theSourceCodeTagTapped(_ sender: NSButton) {

        AppGlobals.openDefaultBrowser(string: theSourceCodeLink)
    }

    @IBAction func theAppleTechnologicalTreeTagTapped(_ sender: NSButton) {

        AppGlobals.openDefaultBrowser(string: theAppleTechnologicalTreeLink)
    }

    @IBAction func thePerseusDarkModeTagTapped(_ sender: Any) {

        AppGlobals.openDefaultBrowser(string: thePerseusDarkModeLink)
    }

    @IBAction func theOpenWeatherClientTagTapped(_ sender: Any) {

        AppGlobals.openDefaultBrowser(string: theOpenWeatherClientLink)
    }

    @IBAction func thePerseusGeoLocationKitTagTapped(_ sender: Any) {

        AppGlobals.openDefaultBrowser(string: thePerseusGeoLocationKitLink)
    }

    @IBAction func thePerseusUISystemKitTagTapped(_ sender: Any) {

        AppGlobals.openDefaultBrowser(string: thePerseusUISystemKitLink)
    }

    @IBAction func thePerseusLoggerTagTapped(_ sender: Any) {

        AppGlobals.openDefaultBrowser(string: thePerseusLoggerLink)
    }

    // MARK: - Initialization

    override func awakeFromNib() {

        log.message("[\(type(of: self))].\(#function)")
    }

    override func viewDidLoad() {

        log.message("[\(type(of: self))].\(#function)")

        // Setup content options.

        self.view.wantsLayer = true
        self.preferredContentSize = NSSize(width: self.view.frame.size.width,
                                           height: self.view.frame.size.height)

        configure()

        // Setup DARK MODE.

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()

        // Setup localization.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        localize()
    }

    // MARK: - Start up Configuration

    private func configure() {

        self.theCopyrightText.backgroundColor = .clear
        self.theCopyrightText.isEditable = false
        self.theCopyrightText.alignment = .center

        self.theCopyrightDetailsText.backgroundColor = .clear
        self.theCopyrightDetailsText.isEditable = false
        self.theCopyrightDetailsText.alignment = .center

        self.theCreditsText.backgroundColor = .clear
        self.theCreditsText.isEditable = false
        self.theCreditsText.alignment = .left

        self.theAppVertionText.stringValue =
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
}

// MARK: - DARK MODE

extension AboutViewController {

    private func callDarkModeSensitiveColours() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }
}

// MARK: - LOCALIZAION

extension AboutViewController: Localizable {

    @objc func localize() {

        log.message("[\(type(of: self))].\(#function)")

        self.theSourceCodeGitHubButton.title = "SourceCodeGitHub".localizedValue
        self.theAppleTechnologicalTreeButton.title = "TheAppleTechnologialTree".localizedValue

        self.theAppVersionLabel.stringValue = "App Version".localizedValue + ":"
        self.theAppNameText.stringValue = "BundleDisplayName".localizedValue

        self.theCopyrightText.string = "Human Readable Copyright Short Text".localizedValue
        self.theCopyrightDetailsText.string = "CopyrightShortDetails".localizedValue

        self.theCreditsText.string = "Credits".localizedValue

        self.theLicenseButton.title = "License".localizedValue
        self.theTermsButton.title = "Terms".localizedValue
        self.theCloseButton.title = "Close".localizedValue
    }
}
