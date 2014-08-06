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
        XCTAssertGreaterThan(Float(-1.0).abs(), 0)
    }
    
    func testSqrt() {
        XCTAssertEqual(2, Float(4.0).sqrt())
    }

    func testFloor () {
        XCTAssertEqual(2, Float(2.9).floor())
    }
    
    func testCeil () {
        XCTAssertEqual(3, Float(2.9).ceil())
    }
    
    func testRound () {
        XCTAssertEqual(3, Float(2.5).round())
        XCTAssertEqual(2, Float(2.4).round())
    }
    
    func testRandom() {
    }

}
