//
//  StringExtensionsTests.swift
//  ExSwift
//
//  Created by ExSwift on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class StringExtensionsSpec: QuickSpec {

    override func spec() {

        /**
        *  String.length
        */
        it("length") {

            expect("".length) == 0
            expect("A".length) == 1
            expect("😱".length) == 1
            expect("∞".length) == 1
            expect("∞aA".length) == 3

        }

        /**
        *  String[x]
        */
        it("subscript") {

            let string = "∆Test😗"

            expect(string[0]) == "∆"
            expect(string[1]) == "T"

            expect(string[string.length - 1]) == "😗"
            expect(string[1..<6]) == "Test😗"

            if let s = "hello"[0] {
                expect(s) == "h"
            } else {
                fail("string[0]")
            }

            expect("ABCD"[0, 2]) == ["A", "C"]

        }

        /**
        *  String.at
        */
        it("at") {

            expect("ABCD".at(0)) == ["A"]
            expect("ABCD".at(0)) == ["ABCD"[0]!]

            expect("ABCD".at(0, 2)) == ["A", "C"]
            expect("ABCD".at(0, 2)) == "ABCD"[0, 2]

        }

        /**
        *  String.explode
        */
        it("explode") {

            expect("A B C".explode(" ")) == ["A", "B", "C"]

            expect("A B C".explode(">")) == ["A B C"]
            expect("A>B C".explode(">")) == ["A", "B C"]

        }

        /**
        *  String.capitalized
        */
        it("capitalized") {

            expect("".capitalized) == ""
            expect("abcdef".capitalized) == "Abcdef"
            expect("Abcdef".capitalized) == "Abcdef"

        }

        /**
        *  String.insert
        */
        it("insert") {

            expect("abcdef".insert(0, "X")) == "Xabcdef"

            expect("abcdef".insert(10, "X")) == "abcdefX"
            expect("abcdef".insert(3, "X")) == "abcXdef"

        }

        /**
        *  String.repeat
        */
        it("repeat operator") {

            expect("A" * 3) == "AAA"
            expect("A" * 0) == ""

        }

        /**
        *  String pattern matching
        */
        describe("matching") {

            it("=~") {

                let string = "ABcd"

                expect(try! string =~ "^A").to(beTrue())

                expect(try! string =~ (pattern: "D$", ignoreCase: true)).to(beTrue())
                expect(try! string =~ "D$").to(beFalse())

                //  String[] all
                let strings = [string, string, string]

                expect(try! strings =~ "^A").to(beTrue())

                expect(try! strings =~ (pattern: "D$", ignoreCase: true)).to(beTrue())
                expect(try! strings =~ "D$").to(beFalse())

            }

            it("|~") {

                //  String[] any
                let strings = ["ABcd", "ABcd", "ABcd"]

                XCTAssertTrue(try! strings |~ "^A")

                XCTAssertTrue(try! strings |~ (pattern: "D$", ignoreCase: true))
                XCTAssertFalse(try! strings |~ "D$")

            }

            it("matches") {

                let string = "AB[31]"

                let matches = try! string.matches("\\d+")!
                let range = matches[0].rangeAtIndex(0)

                let substringRange = range.location..<(range.location + range.length)

                expect(string[substringRange]) == "31"
                expect(try! string.matches("N")!.isEmpty).to(beTrue())

            }

        }


        /**
        *  String contains matches
        */
       describe("containsMatch checks"){
           it("match") {
               expect(try! "Test string for match".containsMatch("for")).to(beTrue())
           }
           it("not match") {
               expect(try! "Test string for match".containsMatch("not for")).to(beFalse())
           }
       }

        /**
        *  ReplaceMatches in string
        */
        describe("ReplaceMatches checks"){
            it("find match to replace") {
                expect(try! "Test_string".replaceMatches("_.*", withString: "_replace")) == "Test_replace"
            }
            
            it("find match to replacei with empty string") {
                expect(try! "Test 111string 222for333 match".replaceMatches("\\d+", withString: "")) == "Test string for match"
            }
            
            it("not find match to replace") {
                expect(try! "Test string for match".replaceMatches("\\d+", withString: "some string")) == "Test string for match"
            }
        }

        /**
        *  String trimming methods
        */
        describe("trimming") {

            it("trimmed") {

                expect("t e".trimmed()) == "t e"
                expect(" AB".trimmed()) == "AB"
                expect("\n ABC   ".trimmed()) == "ABC"
                expect("".trimmed()) == ""
                expect(" \t\n\r".trimmed()) == ""

            }

            describe("trimmedLeft") {

                it("default character set") {

                    expect("ab ".trimmedLeft()) == "ab "
                    expect("ab".trimmedLeft()) == "ab"
                    expect(" AB".trimmedLeft()) == "AB"
                    expect("\n ABC   ".trimmedLeft()) == "ABC   "
                    expect("".trimmedLeft()) == ""
                    expect(" \t\n\r".trimmedLeft()) == ""

                }

                it("with character set") {

                    expect("ab   ".trimmedLeft(characterSet: NSCharacterSet.alphanumericCharacterSet())) == "   "
                    expect("  ab".trimmedLeft(characterSet: NSCharacterSet.alphanumericCharacterSet())) == "  ab"
                    expect("ab".trimmedLeft(characterSet: NSCharacterSet.alphanumericCharacterSet())) == ""

                }

            }

            describe("trimmedRight") {

                it("default character set") {

                    expect("t e".trimmedRight()) == "t e"
                    expect(" AB".trimmedRight()) == " AB"
                    expect("AB ".trimmedRight()) == "AB"
                    expect("\n ABC   ".trimmedRight()) == "\n ABC"
                    expect("".trimmedRight()) == ""
                    expect(" \t\n\r".trimmedRight()) == ""

                }

                it("with character set") {

                    expect("ab   ".trimmedRight(characterSet: NSCharacterSet.alphanumericCharacterSet())) == "ab   "
                    expect("  ab".trimmedRight(characterSet: NSCharacterSet.alphanumericCharacterSet())) == "  "
                    expect("ab".trimmedRight(characterSet: NSCharacterSet.alphanumericCharacterSet())) == ""

                }

            }

            describe("type conversion") {

                it("toDouble") {

                    expect("  7.2 ".toDouble()).to(beCloseTo(7.2, within: 0.0001))
                    expect("-70.211111 ".toDouble()).to(beCloseTo(-70.211111, within: 0.0001))
                    expect("42".toDouble()).to(beCloseTo(42, within: 0.0001))

                    expect("a772.2".toDouble()).to(beNil())

                }

                it("toFloat") {

                    expect("  7.2 ".toFloat()).to(beCloseTo(7.2, within: 0.0001))
                    expect("-70.211111 ".toFloat()).to(beCloseTo(-70.211111, within: 0.0001))
                    expect("42".toFloat()).to(beCloseTo(42, within: 0.0001))

                    expect("a772.2".toFloat()).to(beNil())

                }

                it("toUInt") {

                    expect("  7 ".toUInt()) == 7

                    expect("a772.2".toUInt()).to(beNil())
                    expect("-772".toUInt()).to(beNil())
                    expect("7.5".toUInt()).to(beNil())

                }

                it("toBool") {

                    expect("  TrUe ".toBool()).to(beTrue())
                    expect("  yEs ".toBool()).to(beTrue())

                    expect("  FALSE ".toBool()).to(beFalse())
                    expect("  nO ".toBool()).to(beFalse())

                    expect("".toBool()).to(beNil())
                    expect("jeff".toBool()).to(beNil())
                    expect("0".toBool()).to(beNil())

                }

                it("toDate") {

                    let d : NSDate = " 2015-08-19 \t ".toDate()!

                    let c = NSDateComponents()
                    c.year = 2015
                    c.month = 8
                    c.day = 19

                    let gregorian = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
                    expect(gregorian.dateFromComponents(c)) == d

                    expect("a772.2".toDate()).to(beNil())
                    expect("Tuesday".toDate()).to(beNil())
                    expect("1973-08-19 03:04:55".toDate()).to(beNil())

                }

                it("toDateTime") {

                    let d : NSDate = " 2015-08-19 03:04:34\t ".toDateTime()!

                    let c = NSDateComponents()
                    c.year = 2015
                    c.month = 8
                    c.day = 19
                    c.hour = 3
                    c.minute = 4
                    c.second = 34

                    let gregorian = NSCalendar(identifier: NSCalendarIdentifierGregorian)!
                    expect(gregorian.dateFromComponents(c)) == d

                    expect("a772.2".toDateTime()).to(beNil())
                    expect("Tuesday".toDateTime()).to(beNil())
                    expect("1973-08-19".toDateTime()).to(beNil())

                }

            }

            /**
            *  String.random
            */
            it("random") {

                expect(String.random().length).to(beLessThanOrEqualTo(16))
                expect(String.random(length: 12).length) == 12

            }

        }

    }

}

