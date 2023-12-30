//
//  LocationView.swift, LocationView.xib
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
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class LocationView: NSView {

    // MARK: - Internals

    private let darkModeObserver = DarkModeObserver()

    // MARK: - Outlets

    @IBOutlet var contentView: NSView!

    @IBOutlet private(set) weak var locationNameValueLabel: NSTextField!
    @IBOutlet private(set) weak var geoCoupleDataValueLabel: NSTextField!

    @IBOutlet weak var permissionLabel: NSTextField!
    @IBOutlet weak var permissionValueLabel: NSTextField!

    @IBOutlet private(set) weak var refreshButton: NSButton!

    // MARK: - Actions

    @IBAction func refreshButtonTapped(_ sender: NSButton) {

        log.message("[\(type(of: self))].\(#function)")

        let permit = globals.locationDealer.locationPermit

        if permit == .notDetermined {
            // Allow geo service action.
            globals.locationDealer.askForAuthorization { permit in
                let text = "[\(type(of: self))].\(#function) — .\(permit)"
                log.message(text, .error)
            }
        } else if permit == .allowed {
            // Refresh geo data action.
            try? globals.locationDealer.askForCurrentLocation()
        } else {
            // Open system options action.
            AppGlobals.openTheApp(name: AppGlobals.systemAppName)
        }
    }

    // MARK: - Initialization

    override func viewWillDraw() {
        super.viewWillDraw()

        log.message("[\(type(of: self))].\(#function)")
    }

    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)

        log.message("[\(type(of: self))].\(#function)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")

        localize()
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        log.message("[\(type(of: self))].\(#function)")

        // Setup the view as a reusable control.

        guard let className = type(of: self).className().components(separatedBy: ".").last,
              let nib = NSNib(nibNamed: className, bundle: Bundle(for: type(of: self)))
        else {
            let text = "[\(type(of: self))].\(#function) No nib loaded."
            log.message(text, .error); fatalError(text)
        }

        log.message("[\(type(of: self))].\(#function) \(className)")

        nib.instantiate(withOwner: self, topLevelObjects: nil)

        var newConstraints: [NSLayoutConstraint] = []

        for oldConstraint in contentView.constraints {

            let firstItem = oldConstraint.firstItem === contentView ?
            self : oldConstraint.firstItem

            let secondItem = oldConstraint.secondItem === contentView ?
            self : oldConstraint.secondItem

            newConstraints.append(
                NSLayoutConstraint(item: firstItem as Any,
                                   attribute: oldConstraint.firstAttribute,
                                   relatedBy: oldConstraint.relation,
                                   toItem: secondItem,
                                   attribute: oldConstraint.secondAttribute,
                                   multiplier: oldConstraint.multiplier,
                                   constant: oldConstraint.constant)
            )
        }

        for newView in contentView.subviews {
            self.addSubview(newView)
        }

        self.addConstraints(newConstraints)

        // Setup DARK MODE.

        darkModeObserver.action = { _ in self.callDarkModeSensitiveColours() }
        callDarkModeSensitiveColours()

        // Setup localization.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(localize),
                       name: NSNotification.Name.languageSwitchedManuallyNotification,
                       object: nil)

        // Setup location event handlers.

        nc.addObserver(self, selector: #selector(locationDealerCurrentHandler(_:)),
                       name: .locationDealerCurrentNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerStatusChangedHandler),
                       name: .locationDealerStatusChangedNotification,
                       object: nil)
    }

    // MARK: - Contract

    public func reloadData() {

        if AppGlobals.appDelegate?.location != nil {
            locationNameValueLabel.stringValue = "Location Name Label".localizedValue
        } else {
            locationNameValueLabel.stringValue = "greetings".localizedValue
        }

        permissionValueLabel.stringValue = permissionStatusLocalized
        geoCoupleDataValueLabel.stringValue = geoCoupleDataLocalized
        refreshButton.title = locationRefreshButtonTitleLocalized
    }
}

// MARK: - DARK MODE

extension LocationView {

    private func callDarkModeSensitiveColours() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
    }
}

// MARK: - LOCALIZAION

extension LocationView {

    @objc func localize() {

        log.message("[\(type(of: self))].\(#function)")

        permissionLabel.stringValue = "Permission".localizedValue + ":"

        reloadData()
    }
}

// MARK: - LOCATION DATA EVENT HANDLER

extension LocationView {

    @objc private func locationDealerCurrentHandler(_ notification: Notification) {

        log.message("[\(type(of: self))].\(#function)")

        guard
            let result = notification.object as? Result<PerseusLocation, LocationDealerError>
        else { return }

        switch result {
        case .success(let data):
            AppGlobals.appDelegate?.location = data
        case .failure(let error):
            log.message("\(error)", .error)
        }

        reloadData()
    }

    @objc private func locationDealerStatusChangedHandler() {

        log.message("[\(type(of: self))].\(#function)")

        reloadData()
    }
}

// MARK: - COMPLEX STRINGS LOCALIZED

extension LocationView {

    private var locationRefreshButtonTitleLocalized: String {

#if !TARGET_INTERFACE_BUILDER
   // Run this code only in the app.
        let permit = globals.locationDealer.locationPermit
#else
   // Run this code only in Interface Builder.
        let permit: LocationDealerPermit = .notDetermined
#endif

        var titleLocalized: String = ""

        switch permit {
        case .notDetermined:
            titleLocalized = "Allow Geo... Location Button".localizedValue
        case .deniedForAllAndRestricted:
            titleLocalized = "Go to Settings... Location Button".localizedValue
        case .restricted:
            titleLocalized = "Go to Settings... Location Button".localizedValue
        case .deniedForAllApps:
            titleLocalized = "Go to Settings... Location Button".localizedValue
        case .deniedForTheApp:
            titleLocalized = "Go to Settings... Location Button".localizedValue
        case .allowed:
            titleLocalized = "Refresh Location Button".localizedValue
        }

        return titleLocalized
    }

    private var geoCoupleDataLocalized: String {

        guard let location = AppGlobals.appDelegate?.location else {
            log.message("[\(type(of: self))].\(#function)", .error)
            return "Latitude, Longitude".localizedValue
        }

        let couple = "\(location.latitude.cut(.four)), \(location.longitude.cut(.four))"

        log.message("[\(type(of: self))].\(#function): \(couple)")

        return couple
    }

    private var permissionStatusLocalized: String {

#if !TARGET_INTERFACE_BUILDER
        // Run this code only in the app.
        let permit = globals.locationDealer.locationPermit
#else
        // Run this code only in Interface Builder.
        let permit: LocationDealerPermit = .deniedForAllAndRestricted
#endif

        var statusLocalized: String = ""

        switch permit {
        case .notDetermined:
            statusLocalized = ".notDetermined".localizedValue
        case .deniedForAllAndRestricted:
            statusLocalized = ".deniedForAllAndRestricted".localizedValue
        case .restricted:
            statusLocalized = ".restricted".localizedValue
        case .deniedForAllApps:
            statusLocalized = ".deniedForAllApps".localizedValue
        case .deniedForTheApp:
            statusLocalized = ".deniedForTheApp".localizedValue
        case .allowed:
            statusLocalized = ".allowed".localizedValue
        }

        return statusLocalized
    }
}
