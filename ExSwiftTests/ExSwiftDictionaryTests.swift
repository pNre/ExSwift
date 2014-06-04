//
//  ExSwiftDictionaryTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftDictionaryTests: XCTestCase {
    
    var dictionary = [
        "A": 1,
        "B": 2,
        "C": 3
    ]
    
    func testHas() {
        XCTAssertTrue(dictionary.has("A"))
        XCTAssertFalse(dictionary.has("Z"))
    }

    func testMapValues() {
        let mapped = dictionary.mapValues(mapFunction: { return $1 + 1 })
        XCTAssert(mapped == ["A": 2, "B": 3, "C": 4])
    }
    
    func testMap() {
        let mapped = dictionary.map(mapFunction: { return ($0 + "A", $1 + 1) })
        XCTAssert(mapped == ["AA": 2, "BA": 3, "CA": 4])
    }
    
}
