//
//  LocalizationExtentions.swift
//  XcodeTemplateProject
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 Mikhail Zhigulin of Novosibirsk.
//
//  Licensed under the special license. See LICENSE file.
//  All rights reserved.
//

import Foundation

extension String {
    var localizedValue: String { return NSLocalizedString(self, comment: "") }
}
