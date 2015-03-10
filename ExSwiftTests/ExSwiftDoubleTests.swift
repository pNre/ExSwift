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

    func testRoundToNearest () {
        XCTAssertEqualWithAccuracy(2.5.roundToNearest(0.3), 2.4, 0.01)
        XCTAssertEqualWithAccuracy(0.roundToNearest(0.3), 0.0, 0.01)
        XCTAssertEqualWithAccuracy(4.0.roundToNearest(2), 4.0, 0.01)
        XCTAssertEqualWithAccuracy(10.0.roundToNearest(3), 9.0, 0.01)
        XCTAssertEqualWithAccuracy(-2.0.roundToNearest(3), -3.0, 0.01)
    }
    
    func testFormat(){
        var price:Double = 12356789.424
        var formatter = ExSwiftFormatter.numberFormatter

        formatter.decimalSeparator = "."
        formatter.numberStyle = .DecimalStyle
        formatter.setPrecision(3)

        XCTAssertEqual("12,356,789.424", price.format())
    
        formatter = ExSwiftFormatter.numberFormatter
        formatter.setPrecision(4)
        XCTAssertEqual("12,356,789.4240", price.format())
        
        formatter = ExSwiftFormatter.numberFormatter
        formatter.decimalSeparator = "."
        formatter.numberStyle = .CurrencyStyle
        
        XCTAssertEqual("$12,356,789.4240", price.format())

    }

}
