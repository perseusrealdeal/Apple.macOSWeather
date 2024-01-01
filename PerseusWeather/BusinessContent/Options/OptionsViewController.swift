//
//  OptionsViewController.swift, OptionsWindowController.storyboard
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
// swiftlint:disable file_length
//

import Cocoa

class OptionsViewController: NSViewController, NSTextFieldDelegate {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()

    // MARK: - Outlets

    @IBOutlet private(set) weak var controlAppOptionsSection: NSBox!
    @IBOutlet private(set) weak var controlWeatherOptionsSection: NSBox!
    @IBOutlet private(set) weak var controlCloseButton: NSButton!

    @IBOutlet private(set) weak var labelDarkMode: NSTextField!
    @IBOutlet private(set) weak var labelLanguage: NSTextField!
    @IBOutlet private(set) weak var labelOpenWeatherKey: NSTextField!

    @IBOutlet private(set) weak var labelTemperature: NSTextField!
    @IBOutlet private(set) weak var labelWindSpeed: NSTextField!
    @IBOutlet private(set) weak var labelPressure: NSTextField!
    @IBOutlet private(set) weak var labelTimeFormat: NSTextField!

    @IBOutlet private(set) weak var controlDarkMode: NSSegmentedControl!
    @IBOutlet private(set) weak var controlLanguage: NSSegmentedControl!

    @IBOutlet private(set) weak var controlOpenWeatherKey: NSTextField!
    @IBOutlet private(set) weak var controlUnlockButton: NSButton!

    @IBOutlet private(set) weak var controlTemperature: NSSegmentedControl!
    @IBOutlet private(set) weak var controlWindSpeed: NSSegmentedControl!
    @IBOutlet private(set) weak var controlPressure: NSSegmentedControl!
    @IBOutlet private(set) weak var controlTimeFormat: NSSegmentedControl!

    // MARK: - Actions

    @IBAction func controlDarkModeDidChange(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlDarkMode.selectedSegment)")

        switch sender.selectedSegment {
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

    @IBAction func controlLanguageDidChange(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlLanguage.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppSettings.languageOption = .en
        case 1:
            AppSettings.languageOption = .ru
        case 2:
            AppSettings.languageOption = .system
        default:
            break
        }

        globals.languageSwitcher.switchLanguageIfNeeded(AppSettings.languageOption)
    }

    @IBAction func controlUnlockButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function) - \(controlUnlockButton.stringValue)")

        if self.controlOpenWeatherKey.isEditable {
            lockOpenWeatherKeyHole()
        } else {
            let secret = AppSettings.OpenWeatherAPIOption
            if let secret = secret {
                unlockOpenWeatherKeyHole(stringValue: secret)
            }
        }
    }

    @IBAction func controlTemperatureDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlTemperature.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppSettings.temperatureOption = .standard
        case 1:
            AppSettings.temperatureOption = .metric
        case 2:
            AppSettings.temperatureOption = .imperial
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }

    @IBAction func controlWindSpeedDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlWindSpeed.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppSettings.windSpeedOption = .ms
        case 1:
            AppSettings.windSpeedOption = .kmh
        case 2:
            AppSettings.windSpeedOption = .mph
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }

    @IBAction func controlPressureDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlPressure.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppSettings.pressureOption = .hPa
        case 1:
            AppSettings.pressureOption = .mmHg
        case 2:
            AppSettings.pressureOption = .mb
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }

    @IBAction func controlTimeFormatDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlTimeFormat.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppSettings.timeFormatOption = .long
        case 1:
            AppSettings.timeFormatOption = .short
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }
    @IBAction func closeOptionsWindow(_ sender: NSButton) {

        globals.optionsPresenter.close()
    }

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        log.message("[\(type(of: self))].\(#function)")

        // Setup content options.

        self.view.wantsLayer = true
        self.preferredContentSize = NSSize(width: self.view.frame.size.width,
                                           height: self.view.frame.size.height)

        configure()
        lockOpenWeatherKeyHole()

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

    override func viewDidAppear() {
        super.viewDidAppear()

        log.message("[\(type(of: self))].\(#function)")

        updateControlDarkMode()
        updateControlLanguage()
        updateControlTemperature()
        updateControlWindSpeed()
        updateControlPressure()
        updateControlTimeFormat()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()

        log.message("[\(type(of: self))].\(#function)")

        lockOpenWeatherKeyHole()
    }

    // MARK: - Start up Configuration

    private func configure() {

        log.message("[\(type(of: self))].\(#function)")

        controlOpenWeatherKey.delegate = self
    }

    // MARK: - Events

    func controlTextDidChange(_ obj: Notification) {

        log.message("[\(type(of: self))].\(#function)")

        guard let tf = obj.object as? NSTextField else { return }

        var text = tf.stringValue
        let limit = OPEN_WEATHER_API_KEY_TEXT_LIMIT

        log.message("[\(type(of: self))].\(#function) count: \(text.count)")

        if text.count > limit {
            let index = text.index(text.startIndex, offsetBy: limit)
            text.removeSubrange(index..<text.endIndex)

            tf.stringValue = text
        }

        AppSettings.OpenWeatherAPIOption = tf.stringValue
        if let secret = AppSettings.OpenWeatherAPIOption {
            controlOpenWeatherKey.stringValue = secret
        } else {
            lockOpenWeatherKeyHole()
        }
    }

    // MARK: - Realization, private methods

    private func updateControlDarkMode() {

        switch AppearanceService.DarkModeUserChoice {
        case .auto:
            controlDarkMode.selectedSegment = 2
        case .on:
            controlDarkMode.selectedSegment = 1
        case .off:
            controlDarkMode.selectedSegment = 0
        }
    }

    private func updateControlLanguage() {

        switch AppSettings.languageOption {
        case .system:
            controlLanguage.selectedSegment = 2
        case .ru:
            controlLanguage.selectedSegment = 1
        case .en:
            controlLanguage.selectedSegment = 0
        }
    }

    private func lockOpenWeatherKeyHole() {
        self.controlOpenWeatherKey.isEditable = false

        self.controlOpenWeatherKey.stringValue = ""
        self.controlOpenWeatherKey.placeholderString = "Hidden key hole...".localizedValue

        self.controlUnlockButton.title = "Unlock".localizedValue
    }

    private func unlockOpenWeatherKeyHole(stringValue: String = "") {
        self.controlOpenWeatherKey.isEditable = true

        if stringValue.isEmpty {
            self.controlOpenWeatherKey.stringValue = ""
            self.controlOpenWeatherKey.placeholderString = "Past the key...".localizedValue
        } else {
            self.controlOpenWeatherKey.stringValue = stringValue
        }

        self.controlUnlockButton.title = "Lock".localizedValue
    }

    private func updateControlTemperature() {

        switch AppSettings.temperatureOption {
        case .imperial:
            controlTemperature.selectedSegment = 2
        case .metric:
            controlTemperature.selectedSegment = 1
        case .standard:
            controlTemperature.selectedSegment = 0
        }
    }

    private func updateControlWindSpeed() {

        switch AppSettings.windSpeedOption {
        case .mph:
            controlWindSpeed.selectedSegment = 2
        case .kmh:
            controlWindSpeed.selectedSegment = 1
        case .ms:
            controlWindSpeed.selectedSegment = 0
        }
    }

    private func updateControlPressure() {

        switch AppSettings.pressureOption {
        case .mb:
            controlPressure.selectedSegment = 2
        case .mmHg:
            controlPressure.selectedSegment = 1
        case .hPa:
            controlPressure.selectedSegment = 0
        }
    }

    private func updateControlTimeFormat() {

        switch AppSettings.timeFormatOption {
        case .short:
            controlTimeFormat.selectedSegment = 1
        case .long:
            controlTimeFormat.selectedSegment = 0
        }
    }
}

// MARK: - DARK MODE

extension OptionsViewController {

    private func callDarkModeSensitiveColours() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")

        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }
}

// MARK: - LOCALIZAION

extension OptionsViewController: Localizable {

    @objc func localize() {

        log.message("[\(type(of: self))].\(#function)")

        self.view.window?.title = self.windowTitleLocalized

        controlCloseButton.title = "Close".localizedValue
        controlAppOptionsSection.title = "App Options Section".localizedValue
        controlWeatherOptionsSection.title = "Weather Options Section".localizedValue

        labelDarkMode.stringValue = "Dark Mode".localizedValue
        labelLanguage.stringValue = "Language".localizedValue
        labelOpenWeatherKey.stringValue = "OpenWeather Key".localizedValue

        labelTemperature.stringValue = "Temperature".localizedValue
        labelWindSpeed.stringValue = "Wind Speed".localizedValue
        labelPressure.stringValue = "Pressure".localizedValue
        labelTimeFormat.stringValue = "Time Format".localizedValue

        controlOpenWeatherKey.placeholderString = controlOpenWeatherKey.isEditable ?
        "Past the key...".localizedValue : "Hidden key hole...".localizedValue

        controlUnlockButton.title = controlOpenWeatherKey.isEditable ?
        "Lock".localizedValue : "Unlock".localizedValue

        controlDarkMode.setLabel("Light".localizedValue, forSegment: 0)
        controlDarkMode.setLabel("Dark".localizedValue, forSegment: 1)
        controlDarkMode.setLabel("System".localizedValue, forSegment: 2)

        controlLanguage.setLabel("English".localizedValue, forSegment: 0)
        controlLanguage.setLabel("Russian".localizedValue, forSegment: 1)
        controlLanguage.setLabel("System".localizedValue, forSegment: 2)

        controlTemperature.setLabel("Kelvin".localizedValue + " K", forSegment: 0)
        controlTemperature.setLabel("Celsius".localizedValue + " °C", forSegment: 1)
        controlTemperature.setLabel("Fahrenheit".localizedValue + " °F", forSegment: 2)

        controlWindSpeed.setLabel("meter/sec".localizedValue, forSegment: 0)
        controlWindSpeed.setLabel("km/hour".localizedValue, forSegment: 1)
        controlWindSpeed.setLabel("miles/hour".localizedValue, forSegment: 2)

        controlPressure.setLabel("hPa".localizedValue, forSegment: 0)
        controlPressure.setLabel("mmHg".localizedValue, forSegment: 1)
        controlPressure.setLabel("mb".localizedValue, forSegment: 2)

        controlTimeFormat.setLabel("24-hour".localizedValue, forSegment: 0)
        controlTimeFormat.setLabel("12-hour".localizedValue, forSegment: 1)
    }

    private var windowTitleLocalized: String {
        return "Options Window Title".localizedValue + ": " + "BundleName".localizedValue
    }
}
