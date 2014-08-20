//
//  ExSwiftSequenceTests.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExtensionsSequenceTests: XCTestCase {
    
    var sequence = 1...5
    var emptySequence = 1..<1
    
    func testFirst () {
        var first = SequenceOf(sequence).first()
        XCTAssertEqual(first!, 1)
    }
    
    func testFirstEmotySequence () {
        var first = SequenceOf(emptySequence).first()
        XCTAssertNil(first)
    }
    
    func testSkip () {
        var skipped = SequenceOf(sequence).skip(2)
        XCTAssertEqual(Array(skipped), [3, 4, 5])
    }
    
    func testSkipBeyondEnd () {
        var skipped = SequenceOf(sequence).skip(8)
        XCTAssertEqual(Array(skipped), [])
    }
    
    func testSkipWhile () {
        var skipped = SequenceOf(sequence).skipWhile { $0 < 3 }
        XCTAssertEqual(Array(skipped), [4, 5])
    }
    
    func testSkipWhileBeyondEnd () {
        var skipped = SequenceOf(sequence).skipWhile { $0 < 20 }
        XCTAssertEqual(Array(skipped), [])
    }
    
    func testContains () {
        XCTAssertTrue(SequenceOf(sequence).contains(1))
        XCTAssertFalse(SequenceOf(sequence).contains(56))
    }
    
    func testTake () {
        var take = SequenceOf(sequence).take(2)
        XCTAssertEqual(Array(take), [1, 2])
    }
    
    func testTakeBeyondSequenceEnd () {
        var take = SequenceOf(sequence).take(20)
        XCTAssertEqual(Array(take), [1, 2, 3, 4, 5])
    }
    
    func testTakeWhile () {
        var take = SequenceOf(sequence).takeWhile { $0 != 3 }
        XCTAssertEqual(Array(take), [1, 2])
    }
    
    func testTakeWhileConditionNeverTrue () {
        var take = SequenceOf(sequence).takeWhile { $0 == 7 }
        XCTAssertEqual(Array(take), [])
    }
    
    func testTakeWhileConditionNotMet () {
        var take = SequenceOf(sequence).takeWhile { $0 != 7 }
        XCTAssertEqual(Array(take), [1, 2, 3, 4, 5])
    }
    
    func testIndexOf () {
        XCTAssertEqual(SequenceOf(sequence).indexOf(2)!, 1)
        XCTAssertNil(SequenceOf(sequence).indexOf(77))
    }
    
    func testGet () {
        XCTAssertEqual(SequenceOf(sequence).get(3)!, 3)
        XCTAssertNil(SequenceOf(sequence).get(22))
    }
    
    func testGetRange () {
        var subSequence = SequenceOf(sequence).get(1..<3)
        XCTAssertEqual(Array(subSequence), [2, 3])
        
        subSequence = SequenceOf(sequence).get(0..<0)
        XCTAssertEqual(Array(subSequence), [])
    }
    
    func testGetRangeOutOfBounds () {
        var subSequence = SequenceOf(sequence).get(10..<15)
        XCTAssertEqual(Array(subSequence), [])
    }
    
    func testAny () {
        XCTAssertTrue(SequenceOf(sequence).any { $0 == 1 })
        XCTAssertFalse(SequenceOf(sequence).any { $0 == 77 })
    }
    
    func testFilter () {
        var evens = SequenceOf(sequence).filter { $0 % 2 == 0 }
        XCTAssertEqual(Array(evens), [2, 4])
        
        var odds = SequenceOf(sequence).filter { $0 % 2 == 1 }
        XCTAssertEqual(Array(odds), [1, 3, 5])
        
        var all = SequenceOf(sequence).filter { $0 < 10 }
        XCTAssertEqual(Array(all), [1, 2, 3, 4, 5])
        
        var none = SequenceOf(sequence).filter { $0 > 10 }
        XCTAssertEqual(Array(none), [])
    }
    
    func testReject () {
        var rejected = SequenceOf(sequence).reject { $0 == 3 }
        XCTAssertEqual(Array(rejected), [1, 2, 4, 5])
        
        rejected = SequenceOf(sequence).reject { $0 == 1 }
        XCTAssertEqual(Array(rejected), [2, 3, 4, 5])
        
        rejected = SequenceOf(sequence).reject { $0 == 10 }
        XCTAssertEqual(Array(rejected), [1, 2, 3, 4, 5])
    }
}