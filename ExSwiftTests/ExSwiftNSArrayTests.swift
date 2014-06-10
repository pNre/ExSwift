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
        XCTAssert(array.cast() as Int[] == [10, 0])
        XCTAssert(array.cast() as Bool[] == [true, false])
    }

}
