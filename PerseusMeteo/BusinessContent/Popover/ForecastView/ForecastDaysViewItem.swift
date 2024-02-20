//
//  ForecastDaysViewItem.swift, ForecastDaysViewItem.xib
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

class ForecastDaysViewItem: NSCollectionViewItem {

    public class func makeItem(_ collection: NSCollectionView,
                               _ index: IndexPath,
                               _ data: ForecastDay) -> ForecastDaysViewItem {

        let item = collection.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(
            rawValue: "\(self)"), for: index) as? ForecastDaysViewItem

        item?.data = data

        return (item) ?? ForecastDaysViewItem()
    }

    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected

            view.layer?.borderWidth = isSelected ? 5.0 : 0.0
            makeup()
        }
    }

    var data: ForecastDay? {
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

        guard let day = self.data else { return }

        textField?.stringValue = day.date
        view.layer?.backgroundColor = NSColor.clear.cgColor

        // imageView?.image = NSImage(named: friend.iconName)
        // view.layer?.backgroundColor = NSColor.red.cgColor
    }

    private func makeup() {
        // imageView?.layer?.borderColor = NSColor.customChosenOne.cgColor
        // textField?.textColor = isSelected ? NSColor.customChosenOne : NSColor.black

        view.layer?.backgroundColor = NSColor.clear.cgColor
            // isSelected ? NSColor.red.cgColor : NSColor.clear.cgColor
    }
}
