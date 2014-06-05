//
//  ExSwiftIntTests.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftIntTests: XCTestCase {

    func testTimes() {
        var count = 0

        5.times({
            count++
        })
        
        XCTAssertEqual(5, count)
        
        0.times({
            count++
        })
        
        XCTAssertEqual(5, count)
    }
    
    func testTimesWithIndex() {
        
        var indexes = Array<Int>()
        
        5.times({
            indexes.append($0)
        })
        
        XCTAssert(indexes == [0, 1, 2, 3, 4])
        
    }
    
    func testEven() {
        
        XCTAssertFalse((-1).isEven())
        XCTAssertFalse(3.isEven())
        XCTAssertTrue(4.isEven())
        XCTAssertTrue((-2).isEven())
        
    }
    
    func testOdd() {
        
        XCTAssertTrue((-1).isOdd())
        XCTAssertTrue(3.isOdd())
        XCTAssertFalse(4.isOdd())
        XCTAssertFalse((-2).isOdd())
        
    }
    
    func testRandom() {
        
        10.times({
            var a = Int.random(min: 5, max: 10)
            XCTAssertGreaterThanOrEqual(a, 5)
            XCTAssertLessThanOrEqual(a, 10)
        })

    }
    
    func testAfter() {

        let f = 2.after({ () -> Bool in return true })

        XCTAssertNil(f())
        XCTAssertNil(f())
        XCTAssertTrue(f())
        
        var called = false
        
        let g = 2.after({ called = true })
        
        g()
        g()
        g()

        XCTAssertTrue(called)
        
    }
    
    func testUpTo() {
        
        var result = Array<Int>()
        
        5.upTo(10, { result.append($0) })
     
        XCTAssert(result == Array(5...10))
        
    }
    
    func testDownTo() {
        
        var result = Array<Int>()
        
        3.downTo(0, { result.append($0) })
        
        XCTAssert(result == [3, 2, 1, 0])
        
    }
}
