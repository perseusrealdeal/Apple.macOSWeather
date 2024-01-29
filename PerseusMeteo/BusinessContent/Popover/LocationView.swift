//
//  LocationView.swift, LocationView.xib
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
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class LocationView: NSView {

    // MARK: - Outlets

    @IBOutlet private(set) var viewContent: NSView!

    @IBOutlet private(set) weak var labelLocationNameValue: NSTextField!
    @IBOutlet private(set) weak var labelGeoCoupleDataValue: NSTextField!

    @IBOutlet private(set) weak var labelPermissionTitle: NSTextField!
    @IBOutlet private(set) weak var labelPermissionValue: NSTextField!

    @IBOutlet private(set) weak var buttonRefresh: NSButton!

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
            AppGlobals.openTheApp(name: AppGlobals.systemOptionsAppName)
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

        for oldConstraint in viewContent.constraints {

            let firstItem = oldConstraint.firstItem === viewContent ?
            self : oldConstraint.firstItem

            let secondItem = oldConstraint.secondItem === viewContent ?
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

        for newView in viewContent.subviews {
            self.addSubview(newView)
        }

        self.addConstraints(newConstraints)

        // Setup location event handlers.

        let nc = AppGlobals.notificationCenter

        nc.addObserver(self, selector: #selector(locationDealerCurrentHandler(_:)),
                       name: .locationDealerCurrentNotification,
                       object: nil)

        nc.addObserver(self, selector: #selector(locationDealerStatusChangedHandler),
                       name: .locationDealerStatusChangedNotification,
                       object: nil)
    }

    // MARK: - Contract

    public func reloadData() {

        // TODO: - Add location title if exists

        /*
        if AppGlobals.appDelegate?.location != nil {
            locationNameValueLabel.stringValue = "Location Name Label".localizedValue
        } else {
            locationNameValueLabel.stringValue = "Greetings".localizedValue
        }
        */

        labelPermissionTitle.stringValue = "Label: Permission".localizedValue + ":"
        labelPermissionValue.stringValue = permissionStatusLocalized

        labelLocationNameValue.stringValue = "Greetings".localizedValue

        labelGeoCoupleDataValue.stringValue = geoCoupleDataLocalized
        buttonRefresh.title = locationRefreshButtonTitleLocalized
    }
}

// MARK: - DARK MODE

extension LocationView {

    public func makeup() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
    }
}

// MARK: - LOCALIZATION

extension LocationView {

    public func localize() {

        log.message("[\(type(of: self))].\(#function)")

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
            titleLocalized = "Button: Allow Geo...".localizedValue
        case .deniedForAllAndRestricted:
            titleLocalized = "Button: Go to Settings...".localizedValue
        case .restricted:
            titleLocalized = "Button: Go to Settings...".localizedValue
        case .deniedForAllApps:
            titleLocalized = "Button: Go to Settings...".localizedValue
        case .deniedForTheApp:
            titleLocalized = "Button: Go to Settings...".localizedValue
        case .allowed:
            titleLocalized = "Button: Refresh Current Location".localizedValue
        }

        return titleLocalized
    }

    private var geoCoupleDataLocalized: String {

        guard
            let location = AppGlobals.appDelegate?.location
        else {
            return "Geo Couple".localizedValue
        }

        return "\(location.latitude.cut(.four)), \(location.longitude.cut(.four))"
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
            statusLocalized = "GeoAccess: .notDetermined".localizedValue
        case .deniedForAllAndRestricted:
            statusLocalized = "GeoAccess: .deniedForAllAndRestricted".localizedValue
        case .restricted:
            statusLocalized = "GeoAccess: .restricted".localizedValue
        case .deniedForAllApps:
            statusLocalized = "GeoAccess: .deniedForAllApps".localizedValue
        case .deniedForTheApp:
            statusLocalized = "GeoAccess: .deniedForTheApp".localizedValue
        case .allowed:
            statusLocalized = "GeoAccess: .allowed".localizedValue
        }

        return statusLocalized
    }
}
