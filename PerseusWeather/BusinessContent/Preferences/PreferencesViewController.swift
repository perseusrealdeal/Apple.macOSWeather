//
//  PreferencesViewController.swift
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

class PreferencesViewController: NSViewController, NSTextFieldDelegate, Localizable {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()

    private var gotoSettingsTitle: String {

        var calculatedTitle: String?

        if #available(macOS 10.14, *) {
            calculatedTitle = "Go to Settings..."
        } else {
            calculatedTitle = "Go to Preferences..."
        }

        return calculatedTitle ?? "Open System Options..."
    }

    private var systemAppName: String? {

        var calculatedTitle: String?

        if #available(macOS 10.14, *) {
            calculatedTitle = "System Settings.app"
        } else {
            calculatedTitle = "System Preferences.app"
        }

        return calculatedTitle
    }
    // MARK: - Outlets

    @IBOutlet private(set) weak var controlDarkMode: NSSegmentedControl!
    @IBOutlet private(set) weak var controlLanguage: NSSegmentedControl!

    @IBOutlet private(set) weak var controlStartsOnLogin: NSButton!
    @IBOutlet private(set) weak var controlGotoSettings: NSButton!

    @IBOutlet private(set) weak var controlOpenWeatherKey: NSTextField!
    @IBOutlet private(set) weak var controlUnlockButton: NSButton!

    @IBOutlet weak var controlTemperature: NSSegmentedControl!

    // MARK: - Actions & Events

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
        nc.post(Notification.init(name: .optionTemperatureDidChanged))
    }

    @IBAction func controlStartsOnLoginDidChange(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function) - \(controlStartsOnLogin.state)")

        if controlStartsOnLogin.state == .on {
            AppSettings.startsOnLoginOption = .on

            try? PerseusStartsOnLogin.registration(option: .on)

            recalculateStartsOnLoginValues()
            updateControlStartsOnLogin()
        }

        log.message("[\(type(of: self))].\(#function) - \(AppSettings.startsOnLoginOption)")
    }

    @IBAction func controlGotoSettingsTapped(_ sender: NSButton) {
        log.message("[\(type(of: self))].\(#function)")
        AppGlobals.openTheApp(name: AppGlobals.systemAppName)
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

    @IBAction func closePreferencesWindow(_ sender: NSButton) {
        globals.preferencesPresenter.close()
    }

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

    // MARK: - Native methods

    override func awakeFromNib() {
        log.message("[\(type(of: self))].\(#function)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.wantsLayer = true
        self.preferredContentSize = NSSize(width: self.view.frame.size.width,
                                           height: self.view.frame.size.height)

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()

        controlOpenWeatherKey.delegate = self

        let nc = AppGlobals.notificationCenter
        nc.addObserver(self, selector: #selector(self.localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(self.didBecomeKeyWindow),
                       name: NSWindow.didBecomeKeyNotification,
                       object: nil)

        lockOpenWeatherKeyHole()

        controlGotoSettings.title = self.gotoSettingsTitle
    }

    override func viewDidAppear() {
        super.viewDidAppear()

        updateControlDarkMode()
        updateControlLanguage()
        updateControlTemperature()
        updateControlStartsOnLogin()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        log.message("[\(type(of: self))].\(#function)")

        lockOpenWeatherKeyHole()
    }
    // MARK: - Public variables

    // MARK: - Contract, public methods

    @objc public func localize() {
        log.message("[\(type(of: self))].\(#function)")
    }

    @objc public func didBecomeKeyWindow(_ sender: NSNotification) {
        guard (sender.object as? NSWindow) != nil else { return }

        recalculateStartsOnLoginValues()
        updateControlStartsOnLogin()

        log.message("[\(type(of: self))].\(#function)")
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

    private func recalculateStartsOnLoginValues() {
        if let status = try? PerseusStartsOnLogin.isTurnedOn() {
            AppSettings.startsOnLoginOption = status ? .on : .off
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

    private func updateControlStartsOnLogin() {
        log.message("[\(type(of: self))].\(#function)")
        let status = AppSettings.startsOnLoginOption
        switch status {
        case .on:
            controlStartsOnLogin.state = .on
            controlStartsOnLogin.isEnabled = false
            controlStartsOnLogin.title = "To disable"
            controlGotoSettings.isHidden = false
        case .off:
            controlStartsOnLogin.state = .off
            controlStartsOnLogin.isEnabled = true
            controlStartsOnLogin.title = "Add to login items"
            controlGotoSettings.isHidden = true
        }
    }

    private func callDarkModeSensitiveColours() {
        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
        view.layer?.backgroundColor = NSColor.perseusBlue.cgColor
    }

    private func lockOpenWeatherKeyHole() {
        self.controlOpenWeatherKey.isEditable = false

        self.controlOpenWeatherKey.stringValue = ""
        self.controlOpenWeatherKey.placeholderString = "Hidden key hole..."

        self.controlUnlockButton.title = "Unlock"
    }

    private func unlockOpenWeatherKeyHole(stringValue: String = "") {
        self.controlOpenWeatherKey.isEditable = true

        if stringValue.isEmpty {
            self.controlOpenWeatherKey.stringValue = ""
            self.controlOpenWeatherKey.placeholderString = "Past the key..."
        } else {
            self.controlOpenWeatherKey.stringValue = stringValue
        }

        self.controlUnlockButton.title = "Lock"
    }
}
