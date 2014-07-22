//
//  XCTestCase.swift
//  ExSwift
//
//  Created by pNre on 22/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

//  Might be added in ExSwift
extension XCTestCase {
    
    func XCTAssertEqualArrays <S, T> (first: [S], _ second: [T]) {
        XCTAssertEqual(first.bridgeToObjectiveC(), second.bridgeToObjectiveC())
    }
    
    func XCTAssertNotEqualArrays <S, T> (first: [S], _ second: [T]) {
        XCTAssertNotEqual(first.bridgeToObjectiveC(), second.bridgeToObjectiveC())
    }
    
    func XCTAssertEqualDictionaries <S, T> (first: [S:T], _ second: [S:T]) {
        XCTAssertEqual(first.bridgeToObjectiveC(), second.bridgeToObjectiveC())
    }
    
}
