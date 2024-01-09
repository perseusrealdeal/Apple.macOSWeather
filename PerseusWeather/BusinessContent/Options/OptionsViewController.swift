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
    @IBOutlet private(set) weak var labelTimeFormat: NSTextField!
    @IBOutlet private(set) weak var labelOpenWeatherKey: NSTextField!

    @IBOutlet private(set) weak var controlDarkMode: NSSegmentedControl!
    @IBOutlet private(set) weak var controlLanguage: NSSegmentedControl!
    @IBOutlet private(set) weak var controlTimeFormat: NSSegmentedControl!
    @IBOutlet private(set) weak var controlOpenWeatherKey: NSTextField!
    @IBOutlet private(set) weak var controlUnlockButton: NSButton!

    @IBOutlet private(set) weak var labelTemperature: NSTextField!
    @IBOutlet private(set) weak var labelWindSpeed: NSTextField!
    @IBOutlet private(set) weak var labelPressure: NSTextField!
    @IBOutlet private(set) weak var labelDistance: NSTextField!

    @IBOutlet private(set) weak var controlTemperature: NSSegmentedControl!
    @IBOutlet private(set) weak var controlWindSpeed: NSSegmentedControl!
    @IBOutlet private(set) weak var controlPressure: NSSegmentedControl!
    @IBOutlet private(set) weak var controlDistance: NSSegmentedControl!

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
            AppOptions.languageOption = .en
        case 1:
            AppOptions.languageOption = .ru
        case 2:
            AppOptions.languageOption = .system
        default:
            break
        }

        globals.languageSwitcher.switchLanguageIfNeeded(AppOptions.languageOption)
    }

    @IBAction func controlTimeFormatDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlTimeFormat.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppOptions.timeFormatOption = .hour24
        case 1:
            AppOptions.timeFormatOption = .hour12
        case 2:
            AppOptions.timeFormatOption = .system
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }

    @IBAction func controlUnlockButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function) - \(controlUnlockButton.stringValue)")

        if self.controlOpenWeatherKey.isEditable {
            lockOpenWeatherKeyHole()
        } else {
            let secret = AppOptions.OpenWeatherAPIOption
            if let secret = secret {
                unlockOpenWeatherKeyHole(stringValue: secret)
            }
        }
    }

    @IBAction func controlTemperatureDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlTemperature.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppOptions.temperatureOption = .standard
        case 1:
            AppOptions.temperatureOption = .metric
        case 2:
            AppOptions.temperatureOption = .imperial
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
            AppOptions.windSpeedOption = .ms
        case 1:
            AppOptions.windSpeedOption = .kmh
        case 2:
            AppOptions.windSpeedOption = .mph
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
            AppOptions.pressureOption = .hPa
        case 1:
            AppOptions.pressureOption = .mmHg
        case 2:
            AppOptions.pressureOption = .mb
        default:
            break
        }

        let nc = AppGlobals.notificationCenter
        nc.post(Notification.init(name: .weatherUnitsOptionsDidChanged))
    }

    @IBAction func controlDistanceDidChanged(_ sender: NSSegmentedControl) {

        log.message("[\(type(of: self))].\(#function) - \(controlDistance.selectedSegment)")

        switch sender.selectedSegment {
        case 0:
            AppOptions.distanceOption = .kilometre
        case 1:
            AppOptions.distanceOption = .mile
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
        updateControlTimeFormat()

        updateControlTemperature()
        updateControlWindSpeed()
        updateControlPressure()
        updateControlDistance()
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

        AppOptions.OpenWeatherAPIOption = tf.stringValue
        if let secret = AppOptions.OpenWeatherAPIOption {
            controlOpenWeatherKey.stringValue = secret
        } else {
            lockOpenWeatherKeyHole()
        }
    }

    // MARK: - Realization, private methods

    private func updateControlDarkMode() {

        log.message("[\(type(of: self))].\(#function) \(AppearanceService.DarkModeUserChoice)")

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

        log.message("[\(type(of: self))].\(#function) \(AppOptions.languageOption)")

        switch AppOptions.languageOption {
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

        log.message("[\(type(of: self))].\(#function) \(AppOptions.temperatureOption)")

        switch AppOptions.temperatureOption {
        case .imperial:
            controlTemperature.selectedSegment = 2
        case .metric:
            controlTemperature.selectedSegment = 1
        case .standard:
            controlTemperature.selectedSegment = 0
        }
    }

    private func updateControlWindSpeed() {

        log.message("[\(type(of: self))].\(#function) \(AppOptions.windSpeedOption)")

        switch AppOptions.windSpeedOption {
        case .mph:
            controlWindSpeed.selectedSegment = 2
        case .kmh:
            controlWindSpeed.selectedSegment = 1
        case .ms:
            controlWindSpeed.selectedSegment = 0
        }
    }

    private func updateControlPressure() {

        log.message("[\(type(of: self))].\(#function) \(AppOptions.pressureOption)")

        switch AppOptions.pressureOption {
        case .mb:
            controlPressure.selectedSegment = 2
        case .mmHg:
            controlPressure.selectedSegment = 1
        case .hPa:
            controlPressure.selectedSegment = 0
        }
    }

    private func updateControlTimeFormat() {

        log.message("[\(type(of: self))].\(#function) \(AppOptions.timeFormatOption)")

        switch AppOptions.timeFormatOption {
        case .system:
            controlTimeFormat.selectedSegment = 2
        case .hour12:
            controlTimeFormat.selectedSegment = 1
        case .hour24:
            controlTimeFormat.selectedSegment = 0
        }
    }

    private func updateControlDistance() {

        log.message("[\(type(of: self))].\(#function) \(AppOptions.distanceOption)")

        switch AppOptions.distanceOption {
        case .mile:
            controlDistance.selectedSegment = 1
        case .kilometre:
            controlDistance.selectedSegment = 0
        default:
            controlDistance.isEnabled = false
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
        labelTimeFormat.stringValue = "Time Format".localizedValue

        labelTemperature.stringValue = "Temperature Options Screen".localizedValue
        labelWindSpeed.stringValue = "Wind Speed Options Screen".localizedValue
        labelPressure.stringValue = "Pressure Options Screen".localizedValue
        labelDistance.stringValue = "Distance Options Screen".localizedValue

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

        controlTimeFormat.setLabel("24-hour".localizedValue, forSegment: 0)
        controlTimeFormat.setLabel("12-hour".localizedValue, forSegment: 1)
        controlTimeFormat.setLabel("System".localizedValue, forSegment: 2)

        controlTemperature.setLabel("Kelvin".localizedValue + " K", forSegment: 0)
        controlTemperature.setLabel("Celsius".localizedValue + " °C", forSegment: 1)
        controlTemperature.setLabel("Fahrenheit".localizedValue + " °F", forSegment: 2)

        controlWindSpeed.setLabel("meter/sec".localizedValue, forSegment: 0)
        controlWindSpeed.setLabel("km/hour".localizedValue, forSegment: 1)
        controlWindSpeed.setLabel("miles per hour".localizedValue, forSegment: 2)

        controlPressure.setLabel("hPa".localizedValue, forSegment: 0)
        controlPressure.setLabel("mmHg".localizedValue, forSegment: 1)
        controlPressure.setLabel("mb".localizedValue, forSegment: 2)

        controlDistance.setLabel("Length kilometre".localizedValue, forSegment: 0)
        controlDistance.setLabel("Length mile".localizedValue, forSegment: 1)
    }

    private var windowTitleLocalized: String {
        return "Options Window Title".localizedValue + ": " + "BundleName".localizedValue
    }
}
