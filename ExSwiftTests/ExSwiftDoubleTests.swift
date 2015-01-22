//
//  ExSwiftDoubleTests.swift
//  ExSwift
//
//  Created by pNre on 10/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftDoubleTests: XCTestCase {
    
    func testAbs() {
        XCTAssertGreaterThan(Double(-1.0).abs(), 0)
    }
    
    func testSqrt() {
        XCTAssertEqual(2, Double(4.0).sqrt())
    }

    func testFloor () {
        XCTAssertEqual(2, Double(2.9).floor())
    }
    
    func testCeil () {
        XCTAssertEqual(3, Double(2.9).ceil())
    }
    
    func testRound () {
        XCTAssertEqual(3, Double(2.5).round())
        XCTAssertEqual(2, Double(2.4).round())
    }
    
    func testClamp () {
        XCTAssertEqualWithAccuracy(Double(0.25).clamp(0, 0.5), Double(0.25), 0.01)
        XCTAssertEqualWithAccuracy(Double(2).clamp(0, 0.5), Double(0.5), 0.01)
        XCTAssertEqualWithAccuracy(Double(-2).clamp(0, 0.5), Double(0), 0.01)
    }
    
    func testRandom() {
    }
    
}
