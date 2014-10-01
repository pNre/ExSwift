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
        XCTAssertGreaterThan(Float(-1.0).abs(), Float(0))
    }
    
    func testSqrt() {
        XCTAssertEqual(Float(2), Float(4.0).sqrt())
    }

    func testFloor () {
        XCTAssertEqual(Float(2), Float(2.9).floor())
    }
    
    func testCeil () {
        XCTAssertEqual(Float(3), Float(2.9).ceil())
    }
    
    func testRound () {
        XCTAssertEqual(Float(3), Float(2.5).round())
        XCTAssertEqual(Float(2), Float(2.4).round())
    }
    
    func testRandom() {
    }

}
