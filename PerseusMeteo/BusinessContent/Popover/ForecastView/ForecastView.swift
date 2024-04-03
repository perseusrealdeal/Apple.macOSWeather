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
// swiftlint:disable file_length
//

import Cocoa

@IBDesignable
class ForecastView: NSView {

    // MARK: - Internals

    private let collectionForecastDaysID =
        NSUserInterfaceItemIdentifier(rawValue: "ForecastDays")

    private let collectionForecastHoursID =
        NSUserInterfaceItemIdentifier(rawValue: "ForecastHours")

    // MARK: - View Data Source

    public let dataSource = globals.sourceForecast
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

    @IBOutlet private(set) weak var viewForecastDays: NSCollectionView!
    @IBOutlet private(set) weak var viewForecastHours: NSCollectionView!

    @IBOutlet private(set) weak var viewForecastDetails: MeteoGroupView!

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

        self.viewForecastDays.identifier = collectionForecastDaysID
        self.viewForecastHours.identifier = collectionForecastHoursID

        self.viewForecastDays.dataSource = self
        self.viewForecastHours.dataSource = self

        self.viewForecastDays.delegate = self
        self.viewForecastHours.delegate = self

        self.viewForecastDays.wantsLayer = true
        self.viewForecastDays.backgroundColors = [NSColor.clear]

        self.viewForecastHours.wantsLayer = true
        self.viewForecastHours.backgroundColors = [NSColor.clear]

        wantsLayer = true
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

        // dataSource.refresh()

        reloadDaysCollection()
        reloadHoursCollection()

        // Meteo Data Provider.

        labelMeteoProviderTitle.stringValue = "Label: Meteo Data Provider".localizedValue
        labelMeteoProviderValue.stringValue = dataSource.meteoDataProviderName
    }

    // MARK: - Realization

    private func reloadDaysCollection() {

        log.message("[\(type(of: self))].\(#function)")

        let paths = viewForecastDays.selectionIndexPaths

        viewForecastDays.reloadData()
        viewForecastDays.selectItems(at: paths, scrollPosition: .nearestHorizontalEdge)
    }

    private func reloadHoursCollection() {

        log.message("[\(type(of: self))].\(#function)")

        guard viewForecastDays.selectionIndexPaths.first != nil else {

            viewForecastHours.reloadData()
            viewForecastDetails.data = nil

            return
        }

        let paths = viewForecastHours.selectionIndexPaths

        viewForecastHours.reloadData()
        viewForecastHours.selectItems(at: paths, scrollPosition: .nearestHorizontalEdge)

        viewForecastDetails.reload()
    }
}

// MARK: - NSCollectionViewDataSource, creating collection items

extension ForecastView: NSCollectionViewDataSource {

    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection
        section: Int) -> Int {

        log.message("[\(type(of: self))].\(#function) : \(dataSource.forecastDays.count)")

        // Amount of items in the Forecast Days collection.

        if collectionView.identifier == collectionForecastDaysID {
            return dataSource.forecastDays.count
        }

        // Amount of items in the Forecast Hours collection of the day selected.

        if collectionView.identifier == collectionForecastHoursID,
            dataSource.forecastDays.isEmpty == false {

            if
                let selectedIndexPath = viewForecastDays.selectionIndexPaths.first,
                (selectedIndexPath as NSIndexPath).item != -1 {

                let theDay = dataSource.forecastDays[(selectedIndexPath as NSIndexPath).item]

                return theDay.hours.count
            }
        }

        return 0
    }

    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt
        indexPath: IndexPath) -> NSCollectionViewItem {

        // New Forecast Day.

        if collectionView.identifier == collectionForecastDaysID {

            // Find the day.

            let data = dataSource.forecastDays[(indexPath as NSIndexPath).item]

            // Create a view of the day.

            let viewDay = ForecastDaysViewItem.makeItem(collectionView, indexPath, data)

            log.message("[\(type(of: self))].\(#function)")

            return viewDay
        }

        // New Forecast Hour.

        if collectionView.identifier == collectionForecastHoursID,
            dataSource.forecastDays.isEmpty == false {

            if
                let selectedIndexPath = viewForecastDays.selectionIndexPaths.first,
                (selectedIndexPath as NSIndexPath).item != -1 {

                // Find the day the hour for.

                let day = dataSource.forecastDays[(selectedIndexPath as NSIndexPath).item]

                // Find the hour of the day.

                let hour = day.hours[(indexPath as NSIndexPath).item]

                // Create a new view of the hour.

                let viewHour = ForecastHoursViewItem.makeItem(collectionView, indexPath, hour)

                log.message("[\(type(of: self))].\(#function)")

                return viewHour
            }
        }

        return NSCollectionViewItem()
    }
}

// MARK: - NSCollectionViewDelegate

extension ForecastView: NSCollectionViewDelegate {

    func collectionView(_ collectionView: NSCollectionView,
                        didSelectItemsAt indexPaths: Set<IndexPath>) {

        log.message("[\(type(of: self))].\(#function)")

        if collectionView.identifier == collectionForecastDaysID {
            viewForecastHours.reloadData()
            viewForecastDetails.data = nil
        }

        if collectionView.identifier == collectionForecastHoursID {

            var hourDetails: ForecastHour?

            if
                let selectedIndexPath = viewForecastDays.selectionIndexPaths.first,
                !dataSource.forecastDays.isEmpty,
                (selectedIndexPath as NSIndexPath).item != -1,
                let hourIndexPaths = indexPaths.first {

                let day = dataSource.forecastDays[(selectedIndexPath as NSIndexPath).item]

                hourDetails = day.hours[(hourIndexPaths as NSIndexPath).item]
            }

            viewForecastDetails.data = hourDetails?.getMeteoGroupData()
        }
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
