//
//  ExtensionsTests.swift
//  ExtensionsTests
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExtensionsArrayTests: XCTestCase {

    var array = [1, 2, 3, 4, 5]
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testContains() {
        XCTAssertFalse(array.contains("A"))
        XCTAssertFalse(array.contains(6))
        XCTAssertTrue(array.contains(5))
    }
    
    func testFirst() {
        XCTAssertEqual(1, array.first()!)
    }
    
    func testLast() {
        XCTAssertEqual(5, array.last()!)
    }
    
    func testDifference() {
        var diff1 = array.difference([3, 4])
        var diff2 = array - [3, 4]
        var diff3 = array.difference([3], [5])
        
        XCTAssert(diff1 == [1, 2, 5])
        XCTAssert(diff2 == [1, 2, 5])
        XCTAssert(diff3 == [1, 2, 4])
    }
    
    func testIndexOf() {
        XCTAssertEqual(0, array.indexOf(1))
        XCTAssertEqual(-1, array.indexOf(6))
        XCTAssertEqual(3, array.indexOf(4))
    }
    
    func testIntersection() {
        XCTAssert(array.intersection([]) == [])
        XCTAssert(array.intersection([1]) == [1])
        XCTAssert(array.intersection([1, 2], [1, 2], [1, 3]) == [1])
    }
    
    func testZip() {
        var zip1 = [1, 2].zip(["A", "B"])
        
        var a = zip1[0][0] as Int
        var b = zip1[0][1] as String
        
        XCTAssertEqual(1, a)
        XCTAssertEqual("A", b)
        
        a = zip1[1][0] as Int
        b = zip1[1][1] as String
        
        XCTAssertEqual(2, a)
        XCTAssertEqual("B", b)
    }
    
    func testSample() {
        var singleSample = array.sample()
        var longerSample = array.sample(size: 2)
        
        XCTAssertEqual(1, singleSample.count)
        XCTAssertEqual(2, longerSample.count)
    }
    
    func testSubscriptRange() {
        XCTAssert(array[0..0] == [])
        XCTAssert(array[0..1] == [1])
        XCTAssert(array[0..2] == [1, 2])
    }
    
    func testShuffled() {
        var shuffled = array.shuffled()
        XCTAssert(shuffled.difference(array) == [])
    }
    
    func testShuffle() {
        var toShuffle = array.copy()
        toShuffle.shuffle()
        XCTAssert(toShuffle.difference(array) == [])
    }
    
    func testMax() {
        XCTAssertEqual(5, array.max() as Int)
    }
    
    func testMin() {
        XCTAssertEqual(1, array.min() as Int)
    }
    
    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            
        }
    }*/
    
}
