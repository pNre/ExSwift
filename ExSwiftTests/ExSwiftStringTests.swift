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
        XCTAssertEqual("😗", string[-1]!)
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
    
    func testMatchingOperators () {
        //  String
        let string = "ABcd"

        XCTAssertTrue(string =~ "^A")
        
        XCTAssertTrue(string =~ (pattern: "D$", ignoreCase: true))
        XCTAssertFalse(string =~ "D$")
        
        //  String[] all
        let strings = [string, string, string]
        
        XCTAssertTrue(strings =~ "^A")
        
        XCTAssertTrue(strings =~ (pattern: "D$", ignoreCase: true))
        XCTAssertFalse(strings =~ "D$")
        
        //  String[] any
        let strings_2 = [string, "BC", "DE"]
        
        XCTAssertTrue(strings |~ "^A")
        
        XCTAssertTrue(strings |~ (pattern: "D$", ignoreCase: true))
        XCTAssertFalse(strings |~ "D$")
        
    }

    func testMatches () {
        let string = "AB[31]"

        let matches = string.matches("\\d+")!
        let range = matches[0].rangeAtIndex(0)

        XCTAssert(string[range.location..(range.location + range.length)] == "31")
        XCTAssertTrue(string.matches("N")?.isEmpty)
    }
    
    func testCapitalized () {
        XCTAssert("".capitalized() == "")
        XCTAssert("abcdef".capitalized() == "Abcdef")
        XCTAssert("Abcdef".capitalized() == "Abcdef")
    }

    func testInsert () {
        XCTAssert("abcdef".insert(3, "X") == "abcXdef")
    }

    func testTrimmed () {
        XCTAssert("t e".trimmed() == "t e")
        XCTAssert(" AB".trimmed() == "AB")
        XCTAssert("\n ABC   ".trimmed() == "ABC")
    }
    
    func testLTrimmed () {
        XCTAssert("ab ".ltrimmed() == "ab ")
        XCTAssert("ab".ltrimmed() == "ab")
        XCTAssert(" AB".ltrimmed() == "AB")
        XCTAssert("\n ABC   ".ltrimmed() == "ABC    ")
    }
    
    func testRTrimmed () {
        XCTAssert("t e".rtrimmed() == "t e")
        XCTAssert(" AB".rtrimmed() == " AB")
        XCTAssert("AB ".rtrimmed() == "AB")
        XCTAssert("\n ABC   ".rtrimmed() == "\n ABC")
    }
}
