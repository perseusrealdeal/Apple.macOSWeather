//
//  LocationView.swift, LocationView.xib
//  PerseusMeteo
//
//  Created by Mikhail Zhigulin in 7532.
//
//  Copyright © 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7532 PerseusRealDeal
//
//  The year starts from the creation of the world in the Star temple
//  according to a Slavic calendar. September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class LocationView: NSView {

    // MARK: - Internals

    private(set) var refreshedForPermit: LocationDealerPermit?

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

#if !TARGET_INTERFACE_BUILDER
        // Run this code only in the app.
        refreshedForPermit = globals.locationDealer.locationPermit
#else
        // Run this code only in Interface Builder.
        refreshedForPermit = .deniedForAllAndRestricted
#endif

        labelLocationNameValue.stringValue = "Greetings".localizedValue
        labelGeoCoupleDataValue.stringValue = geoCoupleDataLocalized

        labelPermissionTitle.stringValue = "Label: Permission".localizedValue + ":"

        let permissionLocalized = refreshedForPermit?.permissionLocalKey.localizedValue ?? ""
        labelPermissionValue.stringValue = permissionLocalized

        buttonRefresh.title = refreshedForPermit?.refreshLocalKey.localizedValue ?? ""
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

    private var geoCoupleDataLocalized: String {

        guard
            let location = AppGlobals.appDelegate?.location
        else {
            return "Geo Couple".localizedValue
        }

        return "\(location.latitude.cut(.four)), \(location.longitude.cut(.four))"
    }
}

// MARK: - LOCALIZATION EXTENSIONS

extension LocationDealerPermit {

    var refreshLocalKey: String {
        switch self {
        case .notDetermined:
            return "Button: Allow Geo..."
        case .deniedForAllAndRestricted:
            return "Button: Go to Settings..."
        case .restricted:
            return "Button: Go to Settings..."
        case .deniedForAllApps:
            return "Button: Go to Settings..."
        case .deniedForTheApp:
            return "Button: Go to Settings..."
        case .allowed:
            return "Button: Refresh Current Location"
        }
    }

    var permissionLocalKey: String {
        switch self {
        case .notDetermined:
            return "GeoAccess: .notDetermined"
        case .deniedForAllAndRestricted:
            return "GeoAccess: .deniedForAllAndRestricted"
        case .restricted:
            return "GeoAccess: .restricted"
        case .deniedForAllApps:
            return "GeoAccess: .deniedForAllApps"
        case .deniedForTheApp:
            return "GeoAccess: .deniedForTheApp"
        case .allowed:
            return "GeoAccess: .allowed"
        }
    }
}
