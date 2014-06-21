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
    
    func testDigits () {
        let first = 10.214.digits()
        
        XCTAssertEqualObjects(first.integerPart, [1, 0])
        XCTAssertEqualObjects(first.fractionalPart[0...1], [2, 1])
        
        let second = 0.123.digits()
        
        XCTAssertEqualObjects(second.integerPart, [0])
        XCTAssertEqualObjects(second.fractionalPart[0...1], [1, 2])
        
        let third = 10.0.digits()
        
        XCTAssertEqualObjects(third.integerPart, [1, 0])
        XCTAssertEqualObjects(third.fractionalPart, [0])
    }

    func testFloor () {
        XCTAssertEqual(2, (2.9).floor())
    }
    
    func testCeil () {
        XCTAssertEqual(3, (2.9).ceil())
    }
    
    func testRound () {
        XCTAssertEqual(3, (2.5).round())
        XCTAssertEqual(2, (2.4).round())
    }
    
    func testRandom() {
    }

}
