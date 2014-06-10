//
//  ExSwiftStringTests.swift
//  ExSwift
//
//  Created by ExSwift on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftStringTests: XCTestCase {

    func testLength() {
        XCTAssertEqual(0, "".length)
        XCTAssertEqual(1, "A".length)
        XCTAssertEqual(1, "😱".length)
        XCTAssertEqual(1, "∞".length)
        XCTAssertEqual(3, "∞aA".length)
    }

    func testSubscript() {
        let string = "∆Test😗"

        XCTAssertEqual("∆", string[0]!)
        XCTAssertEqual("T", string[1]!)
        XCTAssertEqual("😗", string[string.length - 1]!)
        XCTAssertEqual("Test😗", string[1..6]!)
    }

    func testRepeat () {
        
        XCTAssertEqual("AAA", "A" * 3)

    }

    func testExplode () {
        
        let string = "A B C"
        XCTAssert(string.explode(" ") == ["A", "B", "C"])
        
    }
    
    func testRandom () {

        XCTAssertLessThanOrEqual(String.random().length, 16)
        XCTAssertEqual(String.random(length: 12).length, 12)
        
    }
    
    func testAt () {
        let array1 = "ABCD".at(0, 2)
        let array2 = "ABCD"[0, 1]
        
        XCTAssert(array1 == ["A", "C"])
        XCTAssert(array2 == ["A", "B"])
    }
    
    func testMatchingOperator () {
        let string_T = "ABcd"

        XCTAssertTrue(string_T ~= "^A")
        
        XCTAssertTrue(string_T ~= (pattern: "D$", ignoreCase: true))
        XCTAssertFalse(string_T ~= "D$")
    }

    func testMatches () {

        let string = "AB[31]"

        let matches = string.matches("\\d+")!
        let range = matches[0].rangeAtIndex(0)

        XCTAssert(string[range.location..(range.location + range.length)] == "31")
        XCTAssertTrue(string.matches("N")?.isEmpty)

    }
    
    func testCapitalized () {
        XCTAssertNil("".capitalized()?)
        XCTAssert("abcdef".capitalized()! == "Abcdef")
        XCTAssert("Abcdef".capitalized()! == "Abcdef")
    }

}
