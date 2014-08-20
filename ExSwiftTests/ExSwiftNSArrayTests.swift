//
//  ExSwiftNSArrayTests.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftNSArrayTests: XCTestCase {
    
    let array = ["A", 10, "B", "C", false]
    
    func testCast() {
        //  Any NSNumber is always converted to Bool or Int
        XCTAssertEqual(array.cast() as [NSNumber], [10, 0])
        XCTAssertEqual(array.cast() as [NSString], ["A", "B", "C"])
        
        XCTAssertEqual(array.cast() as [Int], [10, 0])
    }
    
    func testFlatten () {
        let array = [5, [6, ["A", 7]], 8]
        XCTAssertEqual(array.flatten() as [NSNumber], [5, 6, 7, 8])
        XCTAssertEqual(array.flatten() as [Int], [5, 6, 7, 8])
        XCTAssertEqual(array.flatten() as [String], ["A"])
        
        XCTAssertEqual(array.flattenAny() as [NSObject], [5, 6, "A", 7, 8])
    }
}
