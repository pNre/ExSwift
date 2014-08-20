//
//  ExSwiftRangeTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftRangeTests: XCTestCase {

    func testTimes() {
        var count: Int = 0

        (2..<4).times({
            count++
            return
        })

        XCTAssertEqual(count, 2)

        count = 0

        (2...4).times({
            count++
            return
        })

        XCTAssertEqual(count, 3)
    }

    func testEach() {

        var items = Array<Int>()

        (0..<2).each({
            items.append($0)
        })

        XCTAssertEqual(items, [0, 1])

        (0..<0).each({ (current: Int) in
            XCTFail()
            return
        })

    }

}
