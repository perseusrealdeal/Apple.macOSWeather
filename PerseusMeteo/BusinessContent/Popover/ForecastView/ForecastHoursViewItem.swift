//
//  ForecastHoursViewItem.swift, ForecastHoursViewItem.xib
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

class ForecastHoursViewItem: NSCollectionViewItem {

    public class func makeItem(_ collection: NSCollectionView,
                               _ index: IndexPath,
                               _ data: ForecastHour) -> ForecastHoursViewItem {

        let item = collection.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(
            rawValue: "\(self)"), for: index) as? ForecastHoursViewItem

        item?.data = data

        return (item) ?? ForecastHoursViewItem()
    }

    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected

            view.layer?.borderWidth = isSelected ? 5.0 : 0.0
            makeup()
        }
    }

    var data: ForecastHour? {
        didSet {
            guard isViewLoaded else { return }

            reload()
        }
    }

    let darkModeObserver = DarkModeObserver()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()

        darkModeObserver.action = { _ in self.makeup() }

        makeup()
        reload()
    }

    func configure() {
        view.layer = CALayer()
        view.layer?.cornerRadius = 15.0
        view.layer?.masksToBounds = true

        view.wantsLayer = true
    }

    func reload() {

        guard let hour = self.data else { return }

        textField?.stringValue = hour.label
        view.layer?.backgroundColor = NSColor.clear.cgColor
    }

    private func makeup() {

        view.layer?.backgroundColor = isSelected ? NSColor.red.cgColor : NSColor.clear.cgColor
    }
}
