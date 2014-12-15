//
//  ExSwiftCharacterTests.swift
//  ExSwift
//
//  Created by Cenny Davidsson on 2014-12-09.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest


class ExSwiftCharacterTests: XCTestCase {

    func testToInt () {

        if let int = Character("7").toInt() {
            XCTAssertEqual(int, 7)
        } else {
            XCTFail("Character(\"7\").toInt()")
        }
    }
    
    
}