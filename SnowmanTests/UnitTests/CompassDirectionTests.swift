//
//  CompassDirectionsTests.swift
//  SnowmanTests
//
//  Created by Mikhail Zhigulin in 7531.
//
//  Copyright © 7531 - 7532 Mikhail Zhigulin of Novosibirsk
//  Copyright © 7531 - 7532 PerseusRealDeal
//
//  The year starts from the creation of the world according to a Slavic calendar.
//  September, the 1st of Slavic year.
//
//  See LICENSE for details. All rights reserved.
//

import XCTest

@testable import Snowman

class CompassDirectionTests: XCTestCase {

    // func test_zero() { XCTFail("Tests not yet implemented in \(type(of: self)).") }
    // func test_the_first_success() { XCTAssertTrue(true, "It's done!") }

    func test_sector_north() {

        // log.message("\(CardinalPoint.north)")

        for point in CardinalPoint.north.degrees {

            // log.message("\(point)")

            check_is_degree_in_sector(point.from, expected: .north)
            check_is_degree_in_sector(point.to, expected: .north)
        }
    }

    func test_compass_sectors_count() {

        let compassDegrees = 0...360
        var directions = [CardinalPoint]()

        for degree in compassDegrees {
            if let point = try? WindDegree("\(degree)") {
                directions.append(point.common)
            } else {
                XCTFail("Point for \(degree) not found.")
            }
        }

        // log.message("\(directions.count)")
        // log.message("\(directions.filter({$0 == .northNorthWest }).count)")

        let north = directions.filter({$0 == .north }).count

        let northNorthEast = directions.filter({$0 == .northNorthEast }).count
        let northEast = directions.filter({$0 == .northEast }).count
        let eastNorthEast = directions.filter({$0 == .eastNorthEast }).count

        let east = directions.filter({$0 == .east }).count

        let eastSouthEast = directions.filter({$0 == .eastSouthEast }).count
        let southEast = directions.filter({$0 == .southEast }).count
        let southSouthEast = directions.filter({$0 == .southSouthEast }).count

        let south = directions.filter({$0 == .south }).count

        let southSouthWest = directions.filter({$0 == .southSouthWest }).count
        let southWest = directions.filter({$0 == .southWest }).count
        let westSouthWest = directions.filter({$0 == .westSouthWest }).count

        let west = directions.filter({$0 == .west }).count

        let westNorthWest = directions.filter({$0 == .westNorthWest }).count
        let northWest = directions.filter({$0 == .northWest }).count
        let northNorthWest = directions.filter({$0 == .northNorthWest }).count

        XCTAssertEqual(directions.count, compassDegrees.count)

        XCTAssertEqual(north, 24)

        XCTAssertEqual(northNorthEast, 22)
        XCTAssertEqual(northEast, 23)
        XCTAssertEqual(eastNorthEast, 22)

        XCTAssertEqual(east, 23)

        XCTAssertEqual(eastSouthEast, 22)
        XCTAssertEqual(southEast, 23)
        XCTAssertEqual(southSouthEast, 22)

        XCTAssertEqual(south, 23)

        XCTAssertEqual(southSouthWest, 22)
        XCTAssertEqual(southWest, 23)
        XCTAssertEqual(westSouthWest, 22)

        XCTAssertEqual(west, 23)

        XCTAssertEqual(westNorthWest, 22)
        XCTAssertEqual(northWest, 23)
        XCTAssertEqual(northNorthWest, 22)
    }

    private func check_is_degree_in_sector(_ degree: Double,
                                           expected: CardinalPoint,
                                           file: StaticString = #file,
                                           line: UInt = #line) {

        if let sut = try? WindDegree(degree) {
            XCTAssertEqual(sut.common, expected, file: file, line: line)
        } else {
            XCTFail("Point for \(degree) not found.", file: file, line: line)
            return
        }
    }
}
