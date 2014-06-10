//
//  ExSwiftFloatTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftFloatTests: XCTestCase {

    func testAbs() {
        XCTAssertGreaterThan((-1.0).abs(), 0)
    }
    
    func testSqrt() {
        XCTAssertEqual(2, (4.0).sqrt())
    }

    func testRandom() {
    }

}
