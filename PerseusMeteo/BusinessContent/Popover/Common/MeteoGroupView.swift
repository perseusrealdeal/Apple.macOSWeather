//
//  MeteoGroupView.swift, MeteoGroupView.xib
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
class MeteoGroupView: NSView {

    // MARK: - Data

    var data: MeteoGroupData? {
        didSet {
            reload()
        }
    }

    // MARK: - Outlets

    @IBOutlet private(set) var viewContent: NSView!

    @IBOutlet private(set) weak var title1: NSTextField!
    @IBOutlet private(set) weak var title2: NSTextField!
    @IBOutlet private(set) weak var title3: NSTextField!

    @IBOutlet private(set) weak var title4: NSTextField!
    @IBOutlet private(set) weak var title5: NSTextField!
    @IBOutlet private(set) weak var title6: NSTextField!

    @IBOutlet private(set) weak var title7: NSTextField!
    @IBOutlet private(set) weak var title8: NSTextField!
    @IBOutlet private(set) weak var title9: NSTextField!

    @IBOutlet private(set) weak var value1: NSTextField!
    @IBOutlet private(set) weak var value2: NSTextField!
    @IBOutlet private(set) weak var value3: NSTextField!

    @IBOutlet private(set) weak var value4: NSTextField!
    @IBOutlet private(set) weak var value5: NSTextField!
    @IBOutlet private(set) weak var value6: NSTextField!

    @IBOutlet private(set) weak var value7: NSTextField!
    @IBOutlet private(set) weak var value8: NSTextField!
    @IBOutlet private(set) weak var value9: NSTextField!

    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()

        log.message("[\(type(of: self))].\(#function)")
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
    }

    func applyCompactFonts() {

        let fontSize: CGFloat = 10

        title1.font = NSFont.boldSystemFont(ofSize: fontSize)
        value1.font = NSFont.systemFont(ofSize: fontSize)

        title2.font = NSFont.boldSystemFont(ofSize: fontSize)
        value2.font = NSFont.systemFont(ofSize: fontSize)

        title3.font = NSFont.boldSystemFont(ofSize: fontSize)
        value3.font = NSFont.systemFont(ofSize: fontSize)

        title4.font = NSFont.boldSystemFont(ofSize: fontSize)
        value4.font = NSFont.systemFont(ofSize: fontSize)

        title5.font = NSFont.boldSystemFont(ofSize: fontSize)
        value5.font = NSFont.systemFont(ofSize: fontSize)

        title6.font = NSFont.boldSystemFont(ofSize: fontSize)
        value6.font = NSFont.systemFont(ofSize: fontSize)

        title7.font = NSFont.boldSystemFont(ofSize: fontSize)
        value7.font = NSFont.systemFont(ofSize: fontSize)

        title8.font = NSFont.boldSystemFont(ofSize: fontSize)
        value8.font = NSFont.systemFont(ofSize: fontSize)

        title9.font = NSFont.boldSystemFont(ofSize: fontSize)
        value9.font = NSFont.systemFont(ofSize: fontSize)
    }

    func reload() {

        self.title1.stringValue = data?.title1 ?? "/- 1 -/"
        self.value1.stringValue = data?.value1 ?? "/- 1 -/"

        self.title2.stringValue = data?.title2 ?? "/- 2 -/"
        self.value2.stringValue = data?.value2 ?? "/- 2 -/"

        self.title3.stringValue = data?.title3 ?? "/- 3 -/"
        self.value3.stringValue = data?.value3 ?? "/- 3 -/"

        self.title4.stringValue = data?.title4 ?? "/- 4 -/"
        self.value4.stringValue = data?.value4 ?? "/- 4 -/"

        self.title5.stringValue = data?.title5 ?? "/- 5 -/"
        self.value5.stringValue = data?.value5 ?? "/- 5 -/"

        self.title6.stringValue = data?.title6 ?? "/- 6 -/"
        self.value6.stringValue = data?.value6 ?? "/- 6 -/"

        self.title7.stringValue = data?.title7 ?? "/- 7 -/"
        self.value7.stringValue = data?.value7 ?? "/- 7 -/"

        self.title8.stringValue = data?.title8 ?? "/- 8 -/"
        self.value8.stringValue = data?.value8 ?? "/- 8 -/"

        self.title9.stringValue = data?.title9 ?? "/- 9 -/"
        self.value9.stringValue = data?.value9 ?? "/- 9 -/"
    }
}
