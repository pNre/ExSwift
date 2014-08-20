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
        XCTAssertEqual("Test😗", string[1..<6]!)
        XCTAssertEqual("😗", string[-1]!)
        XCTAssertEqual("hello"[0]!, "h")
        
        XCTAssertEqual("ABCD"[0, 2], ["A", "C"])
    }

    func testRepeat () {
        
        XCTAssertEqual("AAA", "A" * 3)

    }

    func testExplode () {
        
        let string = "A B C"
        XCTAssertEqual(string.explode(" "), ["A", "B", "C"])
        
    }
    
    func testRandom () {

        XCTAssertLessThanOrEqual(String.random().length, 16)
        XCTAssertEqual(String.random(length: 12).length, 12)
        
    }
    
    func testAt () {
        let array1 = "ABCD".at(0, 2)
        XCTAssertEqual(array1, ["A", "C"])
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

        let substringRange = range.location..<(range.location + range.length)
        
        XCTAssertEqual(string[substringRange]!, "31")
        XCTAssertTrue(string.matches("N")!.isEmpty)
    }
    
    func testCapitalized () {
        XCTAssertEqual("".capitalized, "")
        XCTAssertEqual("abcdef".capitalized, "Abcdef")
        XCTAssertEqual("Abcdef".capitalized, "Abcdef")
    }

    func testInsert () {
        XCTAssertEqual("abcdef".insert(10, "X"), "abcdefX")
        XCTAssertEqual("abcdef".insert(3, "X"), "abcXdef")
    }

    func testTrimmed () {
        XCTAssertEqual("t e".trimmed(), "t e")
        XCTAssertEqual(" AB".trimmed(), "AB")
        XCTAssertEqual("\n ABC   ".trimmed(), "ABC")
    }
    
    func testLTrimmed () {
        XCTAssertEqual("ab ".ltrimmed(), "ab ")
        XCTAssertEqual("ab".ltrimmed(), "ab")
        XCTAssertEqual(" AB".ltrimmed(), "AB")
        XCTAssertEqual("\n ABC   ".ltrimmed(), "ABC   ")
    }
    
    func testRTrimmed () {
        XCTAssertEqual("t e".rtrimmed(), "t e")
        XCTAssertEqual(" AB".rtrimmed(), " AB")
        XCTAssertEqual("AB ".rtrimmed(), "AB")
        XCTAssertEqual("\n ABC   ".rtrimmed(), "\n ABC")
    }
}
