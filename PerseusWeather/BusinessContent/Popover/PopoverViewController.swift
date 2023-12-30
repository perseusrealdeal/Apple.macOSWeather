//
//  PopoverViewController.swift, PopoverViewController.storyboard
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
//  Special thanks for the macos-status-bar-apps tutorial goes to Gabriel Theodoropoulos.
//  https://www.appcoda.com/macos-status-bar-apps/
//
// TODO: - Add the mention of Gabriel Theodoropoulos to README.
//
//  Special thanks for the SwiftCustomControl sample goes to Bill Waggoner.
//  https://github.com/ctgreybeard/SwiftCustomControl
//
// TODO: - Add the mention of Bill Waggoner to README.
//
// swiftlint:disable file_length
//

import Cocoa

class PopoverViewController: NSViewController {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()

    // MARK: - Storyboard instance

    class func storyboardInstance() -> NSViewController {

        log.message("[\(type(of: self))].\(#function)")

        let sb = NSStoryboard(name: String(describing: self), bundle: nil)

        guard let screen = sb.instantiateInitialController() as? NSViewController else {
            let text = "PopoverViewController went wrong to be created from the storyboard."
            log.message(text, .error); fatalError(text)
        }

        // Do default setup; don't set any parameter causing loadWindow up, breaks unit tests.

        return screen
    }

    // MARK: - Outlets

    @IBOutlet weak var locationView: LocationView!
    @IBOutlet weak var weatherView: WeatherView!

    @IBOutlet weak var callWeatherButton: NSButton!
    @IBOutlet weak var madeWithLoveLabel: NSTextField!

    @IBOutlet weak var weatherTabViewItem: NSTabViewItem!
    @IBOutlet weak var forecastTabViewItem: NSTabViewItem!

    @IBOutlet weak var quitButton: NSButton!
    @IBOutlet weak var hidePopoverButton: NSButton!
    @IBOutlet weak var aboutButton: NSButton!
    @IBOutlet weak var optionsButton: NSButton!

    // MARK: - Actions

    @IBAction func callWeatherButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        guard globals.statusMenusButtonPresenter.isReadyToCall,
              let location = AppGlobals.appDelegate?.location
        else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return
        }

        globals.statusMenusButtonPresenter.isReadyToCall = false

        let lat = location.latitude.cut(.two).description
        let lon = location.longitude.cut(.two).description

        let callDetails = OpenWeatherDetails(appid: AppGlobals.appKeyOpenWeather,
                                                     format: .currentWeather,
                                                     lat: lat,
                                                     lon: lon)
        log.message(callDetails.urlString)

        do {
            try globals.weatherClient.call(with: callDetails)
        } catch {
            log.message("[\(type(of: self))].\(#function)", .error)
            globals.statusMenusButtonPresenter.isReadyToCall = true
        }
    }

    @IBAction func aboutButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        globals.aboutPresenter.showWindow(sender)
    }

    @IBAction func hidePopoverButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        guard let popover = globals.statusMenusButtonPresenter.popover else { return }
        popover.performClose(sender)
    }

    @IBAction func optionsButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        globals.optionsPresenter.showWindow(sender)
    }

    @IBAction func quitButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        AppGlobals.quitTheApp()
    }

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        // Setup content size.

        self.view.wantsLayer = true
        self.preferredContentSize = NSSize(width: self.view.frame.size.width,
                                           height: self.view.frame.size.height)

        // Setup DARK MODE.

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()

        // Setup localization.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)
        localize()
    }

    // MARK: - Contract

    public func reloadData() {

        guard let weather = self.weatherView else { return }

        weather.reloadData()
    }
}

// MARK: - DARK MODE

extension PopoverViewController {

    private func callDarkModeSensitiveColours() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
        // view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }
}

// MARK: - LOCALIZAION

extension PopoverViewController: Localizable {

    @objc func localize() {

        log.message("[\(type(of: self))].\(#function)")

        // Buttons

        callWeatherButton.title = "Call Weather Button".localizedValue
        madeWithLoveLabel.stringValue = "Made with Love".localizedValue

        weatherTabViewItem.label = "Weather Tab Label".localizedValue
        forecastTabViewItem.label = "Forecast Tab Label".localizedValue

        aboutButton.title = "About Button".localizedValue
        hidePopoverButton.title = "Hide Button".localizedValue
        optionsButton.title = "Options Button".localizedValue

        quitButton.title = "Quit Button".localizedValue
    }
}
