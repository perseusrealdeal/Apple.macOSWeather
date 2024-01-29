//
//  JsonDataDictionaryGift.swift
//  Gifts
//
//  Just a gift. Tested with Swift 4.2 compiler.
//  https://gist.github.com/perseusrealdeal/918c25633122e64d51f363f00059f6f8
//

/* Perseus Logger source code */
/* https://gist.github.com/perseusrealdeal/df456a9825fcface44eca738056eb6d5 */

import Foundation

public class JsonDataDictionary {

    // MARK: - Internals

    private var data: (() -> Data)?

    // MARK: - Contract

    public var path: (() -> Data)? {
        didSet {
            data = path
        }
    }

    public var json: [String: Any]? {

        guard let source = data else { return nil }

        let dataSource = source()
        let opts: JSONSerialization.ReadingOptions = [.mutableContainers]

        do {
            let object = try JSONSerialization.jsonObject(with: dataSource, options: opts)

            guard
                let json = object as? [String: Any]
            else {
                log.message("[\(type(of: self))].\(#function), Dictionary.", .error)
                return nil
            }

            return json

        } catch {
            log.message("[\(type(of: self))].\(#function) \(error)", .error)
            return nil
        }
    }
}
