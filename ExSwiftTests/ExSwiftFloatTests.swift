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
        
        XCTAssert(first.integerPart == [1, 0])
        XCTAssert(first.fractionalPart[0...1] == [2, 1])
        
        let second = 0.123.digits()
        
        XCTAssert(second.integerPart == [0])
        XCTAssert(second.fractionalPart[0...1] == [1, 2])
        
        let third = 10.0.digits()
        
        XCTAssert(third.integerPart == [1, 0])
        XCTAssert(third.fractionalPart == [0])
    }

    func testRandom() {
    }

}
