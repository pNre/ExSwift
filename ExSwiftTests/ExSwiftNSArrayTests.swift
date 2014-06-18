//
//  ExSwiftNSArrayTests.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftNSArrayTests: XCTestCase {

    let array = ["A", 10, "B", "C", false]
    
    func testCast() {
        //  Any NSNumber is always converted to Bool or Int
        XCTAssertEqualObjects(array.cast() as Int[], [10, 0])
        XCTAssertEqualObjects(array.cast() as Bool[], [true, false])
    }

    func testFlatten () {
        let array = [5, [6, ["A", 7]], 8]
        XCTAssertEqualObjects(array.flatten() as Int[], [5, 6, 7, 8])
    }
}
