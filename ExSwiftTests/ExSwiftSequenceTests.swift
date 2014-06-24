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
    var emptySequence = 1..1
    
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
        XCTAssertEqualObjects(Array(skipped), [3,4,5])
    }
    
    func testSkipBeyondEnd () {
        var skipped = SequenceOf(sequence).skip(8)
        XCTAssertEqualObjects(Array(skipped), [])
    }
    
    func testSkipWhile () {
        var skipped = SequenceOf(sequence).skipWhile { $0 < 3 }
        XCTAssertEqualObjects(Array(skipped), [4,5])
    }
    
    func testSkipWhileBeyondEnd () {
        var skipped = SequenceOf(sequence).skipWhile { $0 < 20 }
        XCTAssertEqualObjects(Array(skipped), [])
    }
    
    func testContains () {
        XCTAssertTrue(SequenceOf(sequence).contains(1))
        XCTAssertFalse(SequenceOf(sequence).contains(56))
    }
}