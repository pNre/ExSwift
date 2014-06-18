//
//  ExSwiftDictionaryTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExSwiftDictionaryTests: XCTestCase {
    
    var dictionary = [
        "A": 1,
        "B": 2,
        "C": 3
    ]
    
    func testHas() {
        XCTAssertTrue(dictionary.has("A"))
        XCTAssertFalse(dictionary.has("Z"))
    }

    func testMapValues() {
        let mapped = dictionary.mapValues(mapFunction: { key, value -> Int in return value + 1 })
        XCTAssertEqualObjects(mapped, ["A": 2, "B": 3, "C": 4])
    }
    
    func testMap() {
        let mapped = dictionary.map(mapFunction: { key, value -> (String, Int) in return (key + "A", value + 1) })
        XCTAssertEqualObjects(mapped, ["AA": 2, "BA": 3, "CA": 4])
    }
    
    func testFilter() {
        let filtered = dictionary.filter { key, _ in return key != "A" }
        XCTAssertEqualObjects(filtered, ["B": 2, "C": 3])
    }

    func testIsEmpty() {
        let e = Dictionary<String, String>()

        XCTAssertTrue(e.isEmpty())
        XCTAssertFalse(dictionary.isEmpty())
    }

    func testShift() {
        let (key, value) = dictionary.shift()
        
        XCTAssertEqual(2, dictionary.count)
        XCTAssertNotNil(key)
        XCTAssertNotNil(value)
    }
    
    func testGroupBy() {
        let group = [
            "A": 2,
            "B": 4,
            "C": 5
        ]
        
        let g = group.groupBy(groupingFunction: {
            _, value -> Bool in
            return (value % 2 == 0)
        })
        
        XCTAssertEqualObjects(Array(g.keys), [false, true])
        XCTAssertEqualObjects(Array(g[true]!), [2, 4])
        XCTAssertEqualObjects(Array(g[false]!), [5])
    }
    
    func testCountBy() {
        let group = [
            "A": 2,
            "B": 4,
            "C": 5
        ]
        
        let g = group.countBy(groupingFunction: {
            _, value -> Bool in
            return (value % 2 == 0)
        })
        
        XCTAssertEqualObjects(g, [false: 1, true: 2])
    }
    
    func testAny() {
        let any = dictionary.any {
            _, value -> Bool in
            return value % 2 == 0
        }

        XCTAssertTrue(any)
    }

    func testAll() {
        let all = dictionary.all {
            _, value -> Bool in
            return value % 2 == 0
        }
        
        XCTAssertFalse(all)
    }

    func testReduce () {
        let reduced = dictionary.reduce(Dictionary<Int, String>(), {
            (var initial: Dictionary<Int, String>, couple: (String, Int)) in
            initial.updateValue(couple.0, forKey: couple.1)
            return initial
        })
        
        XCTAssertEqualObjects(reduced, [2: "B", 3: "C", 1: "A"])
    }
    
    func testDifference () {
        let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
        let dictionary2 = [ "A": 1 ]
        let dictionary3 = [ "B": 2, "C": 3 ]
        
        XCTAssertEqualObjects(dictionary1.difference(dictionary2, dictionary3), [:])
        XCTAssertEqualObjects(dictionary1 - dictionary2, ["C": 3, "B": 2])
    }
    
    func testUnion () {
        let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
        let dictionary2 = [ "A": 1 ]
        let dictionary3 = [ "D": 4 ]
        
        XCTAssertEqualObjects(dictionary1.union(dictionary2, dictionary3), [ "A": 1, "B": 2, "C": 3, "D": 4 ])
        XCTAssertEqualObjects(dictionary1 | dictionary2, dictionary1)
    }
    
    func testIntersection () {
        let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
        let dictionary2 = [ "A": 1 ]
        let dictionary3 = [ "D": 4 ]

        XCTAssertEqualObjects(dictionary1.intersection(dictionary2), ["A": 1])
        XCTAssertEqualObjects(dictionary1.intersection(dictionary3), [:])
        XCTAssertEqualObjects(dictionary1 & dictionary1, dictionary1)
    }
    
    func testPick () {
        let dictionary = [1: "A", 2: "B", 3: "C"]
        
        let pick1 = dictionary.pick([1, 3])
        let pick2 = dictionary.pick(1, 3)

        XCTAssertEqualObjects(pick1, [1: "A", 3: "C"])
        XCTAssertEqualObjects(pick2, pick1)
        XCTAssertEqualObjects(dictionary.pick(), [:])
    }
}
