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
    
    func testDigits () {
        let first = Float(10.214).digits()
        
        XCTAssertEqualArrays(first.integerPart, [1, 0])
        XCTAssertEqualArrays(first.fractionalPart[0...1], [2, 1])
        
        let second = Float(0.123).digits()
        
        XCTAssertEqualArrays(second.integerPart, [0])
        XCTAssertEqualArrays(second.fractionalPart[0...1], [1, 2])
        
        let third = Float(10.0).digits()
        
        XCTAssertEqualArrays(third.integerPart, [1, 0])
        XCTAssertEqualArrays(third.fractionalPart, [0])
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
