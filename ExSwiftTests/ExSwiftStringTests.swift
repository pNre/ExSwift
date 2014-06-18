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
        XCTAssertEqualObjects(string.explode(" "), ["A", "B", "C"])
        
    }
    
    func testRandom () {

        XCTAssertLessThanOrEqual(String.random().length, 16)
        XCTAssertEqual(String.random(length: 12).length, 12)
        
    }
    
    func testAt () {
        let array1 = "ABCD".at(0, 2)
        let array2 = "ABCD"[0, 1]
        
        XCTAssertEqualObjects(array1, ["A", "C"])
        XCTAssertEqualObjects(array2, ["A", "B"])
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

        XCTAssertEqualObjects(string[range.location..(range.location + range.length)], "31")
        XCTAssertTrue(string.matches("N")?.isEmpty)
    }
    
    func testCapitalized () {
        XCTAssertEqualObjects("".capitalized(), "")
        XCTAssertEqualObjects("abcdef".capitalized(), "Abcdef")
        XCTAssertEqualObjects("Abcdef".capitalized(), "Abcdef")
    }

    func testInsert () {
        XCTAssertEqualObjects("abcdef".insert(3, "X"), "abcXdef")
    }

    func testTrimmed () {
        XCTAssertEqualObjects("t e".trimmed(), "t e")
        XCTAssertEqualObjects(" AB".trimmed(), "AB")
        XCTAssertEqualObjects("\n ABC   ".trimmed(), "ABC")
    }
    
    func testLTrimmed () {
        XCTAssertEqualObjects("ab ".ltrimmed(), "ab ")
        XCTAssertEqualObjects("ab".ltrimmed(), "ab")
        XCTAssertEqualObjects(" AB".ltrimmed(), "AB")
        XCTAssertEqualObjects("\n ABC   ".ltrimmed(), "ABC   ")
    }
    
    func testRTrimmed () {
        XCTAssertEqualObjects("t e".rtrimmed(), "t e")
        XCTAssertEqualObjects(" AB".rtrimmed(), " AB")
        XCTAssertEqualObjects("AB ".rtrimmed(), "AB")
        XCTAssertEqualObjects("\n ABC   ".rtrimmed(), "\n ABC")
    }
}
