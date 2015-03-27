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
        
        if let s = "hello"[0] {
            XCTAssertEqual(s, "h")
        } else {
            XCTFail("string[0]")
        }
            
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
        XCTAssertEqual("".trimmed(), "")
        XCTAssertEqual(" \t\n\r".trimmed(), "")
    }
    
    func testLTrimmed () {
        XCTAssertEqual("ab ".ltrimmed(), "ab ")
        XCTAssertEqual("ab".ltrimmed(), "ab")
        XCTAssertEqual(" AB".ltrimmed(), "AB")
        XCTAssertEqual("\n ABC   ".ltrimmed(), "ABC   ")
        XCTAssertEqual("".ltrimmed(), "")
        XCTAssertEqual(" \t\n\r".ltrimmed(), "")
    }
    
    func testRTrimmed () {
        XCTAssertEqual("t e".rtrimmed(), "t e")
        XCTAssertEqual(" AB".rtrimmed(), " AB")
        XCTAssertEqual("AB ".rtrimmed(), "AB")
        XCTAssertEqual("\n ABC   ".rtrimmed(), "\n ABC")
        XCTAssertEqual("".rtrimmed(), "")
        XCTAssertEqual(" \t\n\r".rtrimmed(), "")
    }
    
    func testLTrimmedForSet () {
        XCTAssertEqual("ab   ".ltrimmed(NSCharacterSet.alphanumericCharacterSet()), "   ")
        XCTAssertEqual("  ab".ltrimmed(NSCharacterSet.alphanumericCharacterSet()), "  ab")
        XCTAssertEqual("ab".ltrimmed(NSCharacterSet.alphanumericCharacterSet()), "")
    }
    
    func testRTrimmedForSet () {
        XCTAssertEqual("ab   ".rtrimmed(NSCharacterSet.alphanumericCharacterSet()), "ab   ")
        XCTAssertEqual("  ab".rtrimmed(NSCharacterSet.alphanumericCharacterSet()), "  ")
        XCTAssertEqual("ab".rtrimmed(NSCharacterSet.alphanumericCharacterSet()), "")
    }

    func testToDouble() {
        var d : Double = "  7.2 ".toDouble()!
        XCTAssertEqual(7.2, d)

        d = "-70.211111".toDouble()!
        XCTAssertEqual(-70.211111, d)

        d = "42".toDouble()!
        XCTAssertEqual(42, d)

       XCTAssertNil("a772.2".toDouble())
    }

    func testToFloat() {
        var f : Float = "  7.2 ".toFloat()!
        XCTAssertEqual(Float(7.2), f)

        f = "-70.211111".toFloat()!
        XCTAssertEqual(Float(-70.211111), f)

        XCTAssertNil("a772.2".toFloat())
    }

    func testToUInt() {
        var u : UInt = "  7 ".toUInt()!
        XCTAssertEqual(UInt(7), u)

        XCTAssertNil("a772.2".toUInt())
        XCTAssertNil("-772".toUInt())
        XCTAssertNil("7.5".toUInt())
    }

    func testToBool() {
        var b = "  TrUe ".toBool()!
        XCTAssertEqual(true, b)
        b = "  yEs ".toBool()!
        XCTAssertEqual(true, b)

        b = "  FALSE ".toBool()!
        XCTAssertEqual(false, b)
        b = "  nO ".toBool()!
        XCTAssertEqual(false, b)

        XCTAssertNil("".toBool())
        XCTAssertNil("jeff".toBool())
        XCTAssertNil("0".toBool())
    }

    func testToDate() {
        var d : NSDate = " 2015-08-19 \t ".toDate()!

        var c = NSDateComponents()
        c.year = 2015
        c.month = 8
        c.day = 19

        var gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)!
        var expected = gregorian.dateFromComponents(c)!

        XCTAssertEqual(expected, d)

        XCTAssertNil("a772.2".toDate())
        XCTAssertNil("Tuesday".toDate())
        XCTAssertNil("1973-08-19 03:04:55".toDate())
    }

    func testToDateTime() {
        var d : NSDate = " 2015-08-19 03:04:34\t ".toDateTime()!

        var c = NSDateComponents()
        c.year = 2015
        c.month = 8
        c.day = 19
        c.hour = 3
        c.minute = 4
        c.second = 34

        var gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)!
        var expected = gregorian.dateFromComponents(c)!

        XCTAssertEqual(expected, d)

        XCTAssertNil("a772.2".toDateTime())
        XCTAssertNil("Tuesday".toDateTime())
        XCTAssertNil("1973-08-19".toDateTime())
    }
}
