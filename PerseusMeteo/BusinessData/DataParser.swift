//
//  DataParser.swift
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

import Foundation

public class DataParser {

    public var data: (() -> Data)? {
        didSet {
            log.message("[\(type(of: self))].\(#function).")
        }
    }

    public var json: [String: Any]? {

        guard let source = data else { return nil }

        let dataSource = source()

        guard !dataSource.isEmpty else { return nil }

        var jsonSource = [String: Any]()

        do {
            if let value = try JSONSerialization.jsonObject(with: dataSource,
                                                            options: .mutableContainers)
                as? [String: Any] {

                jsonSource = value
            } else {
                log.message("[\(type(of: self))].\(#function) JSON not valid.", .error)
                return nil
            }
        } catch {
            log.message("[\(type(of: self))].\(#function) \(error)", .error)
            return nil
        }

        return jsonSource
    }
}
