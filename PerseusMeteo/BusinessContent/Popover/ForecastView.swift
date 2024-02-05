//
//  ForecastView.swift, ForecastView.xib
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

import Cocoa

@IBDesignable
class ForecastView: NSView {

    // MARK: - View Data Source

    public var dataSource = ForecastParser()
    public var progressIndicator: Bool = false {
        didSet {
            if progressIndicator {
                indicator.isHidden = false
                indicator.startAnimation(nil)
            } else {
                indicator.isHidden = true
                indicator.stopAnimation(nil)
            }
        }
    }

    // MARK: - Outlets

    @IBOutlet private(set) var contentView: NSView!

    @IBOutlet private(set) weak var labelMeteoProviderTitle: NSTextField!
    @IBOutlet private(set) weak var labelMeteoProviderValue: NSTextField!

    @IBOutlet private(set) weak var indicator: NSProgressIndicator!

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
        progressIndicator = false
    }

    required public init?(coder: NSCoder) {
        super.init(coder: coder)

        log.message("[\(type(of: self))].\(#function)")

        // Create a new instance from *xib and reference it to contentView outlet.

        guard
            let className = type(of: self).className().components(separatedBy: ".").last,
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
    }

    // MARK: - Contract

    public func reloadData() {

        log.message("[\(type(of: self))].\(#function)")

        dataSource.refresh()

        // Meteo Data Provider.

        labelMeteoProviderTitle.stringValue = "Label: Meteo Data Provider".localizedValue
        labelMeteoProviderValue.stringValue = dataSource.meteoDataProviderName
    }
}

// MARK: - DARK MODE

extension ForecastView {

    public func makeup() {

        log.message("[\(type(of: self))].\(#function), DarkMode: \(DarkMode.style)")
    }
}

// MARK: - LOCALIZATION

extension ForecastView {

    public func localize() {

        log.message("[\(type(of: self))].\(#function)")

        reloadData()
    }
}
