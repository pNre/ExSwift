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
        XCTAssertEqualArrays(array.cast() as Array<NSNumber>, [10, 0])
        XCTAssertEqualArrays(array.cast() as Array<NSString>, ["A", "B", "C"])
        
        XCTAssertEqualArrays(array.cast() as [Int], [10, 0])
    }
    
    func testFlatten () {
        let array = [5, [6, ["A", 7]], 8]
        XCTAssertEqualArrays(array.flatten() as Array<NSNumber>, [5, 6, 7, 8])
        XCTAssertEqualArrays(array.flatten() as [Int], [5, 6, 7, 8])
        XCTAssertEqualArrays(array.flatten() as [String], ["A"])
        
        XCTAssertEqualArrays(array.flattenAny(), [5, 6, "A", 7, 8])
    }
}
