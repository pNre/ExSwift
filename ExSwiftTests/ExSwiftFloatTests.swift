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
    
    func testClamp () {
        XCTAssertEqualWithAccuracy(Float(0.25).clamp(0, 0.5), Float(0.25), 0.01)
        XCTAssertEqualWithAccuracy(Float(2).clamp(0, 0.5), Float(0.5), 0.01)
        XCTAssertEqualWithAccuracy(Float(-2).clamp(0, 0.5), Float(0), 0.01)
    }
    
    func testRandom() {
    }
    
    func testFormat(){
        var price:Float = 789.424
        var formatter = ExSwiftFormatter.numberFormatter

        formatter.decimalSeparator = "."
        formatter.numberStyle = .DecimalStyle
        formatter.setPrecision(3)

        XCTAssertEqual("789.424", price.format())
        
        formatter = ExSwiftFormatter.numberFormatter
        formatter.setPrecision(4)
        XCTAssertEqual("789.4240", price.format())
        
        formatter = ExSwiftFormatter.numberFormatter
        formatter.decimalSeparator = "."
        formatter.numberStyle = .CurrencyStyle
        
        XCTAssertEqual("$789.4240", price.format())
        
    }

}
