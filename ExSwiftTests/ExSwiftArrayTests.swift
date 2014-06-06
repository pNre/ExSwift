//
//  ExtensionsTests.swift
//  ExtensionsTests
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExtensionsArrayTests: XCTestCase {

    var array: Array<Int> = []

    override func setUp() {
        super.setUp()
        array = [1, 2, 3, 4, 5]
    }
    
    func testReject () {
        var odd = array.reject({
            return $0 % 2 == 0
        })

        XCTAssert(odd == [1, 3, 5])
    }

    func testEach() {
        var result = Array<Int>()
        
        array.each({
            result.append($0)
        })
        
        XCTAssert(result == array)
        
        result.removeAll(keepCapacity: true)
        
        array.each({
            (index: Int, item: Int) in
            result.append(index)
        })
        
        XCTAssert(result == array.map( { return $0 - 1 } ))
    }
    
    func testRange() {
        XCTAssert(Array<Int>.range(0..2) == [0, 1])
        XCTAssert(Array<Int>.range(0...2) == [0, 1, 2])
    }
    
    func testContains() {
        XCTAssertFalse(array.contains("A"))
        XCTAssertFalse(array.contains(6))
        XCTAssertTrue(array.contains(5))
    }
    
    func testFirst() {
        XCTAssertEqual(1, array.first()!)
    }
    
    func testLast() {
        XCTAssertEqual(5, array.last()!)
    }
    
    func testDifference() {
        var diff1 = array.difference([3, 4])
        var diff2 = array - [3, 4]
        var diff3 = array.difference([3], [5])
        
        XCTAssert(diff1 == [1, 2, 5])
        XCTAssert(diff2 == [1, 2, 5])
        XCTAssert(diff3 == [1, 2, 4])
    }
    
    func testIndexOf() {
        XCTAssertEqual(0, array.indexOf(1))
        XCTAssertEqual(-1, array.indexOf(6))
        XCTAssertEqual(3, array.indexOf(4))
    }
    
    func testIntersection() {
        XCTAssert(array.intersection([]) == [])
        XCTAssert(array.intersection([1]) == [1])
        XCTAssert(array.intersection([1, 2], [1, 2], [1, 3]) == [1])
    }
    
    func testUnion() {
        XCTAssert(array.union([1]) == array)
        XCTAssert(array.union([]) == array)
        XCTAssert(array.union([6]) == [1, 2, 3, 4, 5, 6])
    }
    
    func testZip() {
        var zip1 = [1, 2].zip(["A", "B"])
        
        var a = zip1[0][0] as Int
        var b = zip1[0][1] as String
        
        XCTAssertEqual(1, a)
        XCTAssertEqual("A", b)
        
        a = zip1[1][0] as Int
        b = zip1[1][1] as String
        
        XCTAssertEqual(2, a)
        XCTAssertEqual("B", b)
    }
    
    func testSample() {
        var singleSample = array.sample()
        var longerSample = array.sample(size: 2)
        
        XCTAssertEqual(1, singleSample.count)
        XCTAssertEqual(2, longerSample.count)
    }

    func testSubscriptRange() {
        XCTAssert(array[0..0] == [])
        XCTAssert(array[0..1] == [1])
        XCTAssert(array[0..2] == [1, 2])
    }

    func testShuffled() {
        var shuffled = array.shuffled()
        XCTAssert(shuffled.difference(array) == [])
    }

    func testShuffle() {
        var toShuffle = array.copy()
        toShuffle.shuffle()
        XCTAssert(toShuffle.difference(array) == [])
    }

    func testMax() {
        XCTAssertEqual(5, array.max() as Int)
    }

    func testMin() {
        XCTAssertEqual(1, array.min() as Int)
    }
    
    func testTake() {
        XCTAssert(array.take(3) == [1, 2, 3])
        XCTAssert(array.take(0) == [])
    }

    func testPop() {
        XCTAssertEqual(5, array.pop())
        XCTAssert(array == [1, 2, 3, 4])
    }

    func testPush() {
        array.push(6)
        XCTAssertEqual(6, array.last()!)
    }

    func testShift() {
        XCTAssertEqual(1, array.shift())
        XCTAssert(array == [2, 3, 4, 5])
    }

    func testUnshift() {
        array.unshift(0)
        XCTAssertEqual(0, array.first()!)
    }

    func testRemove() {
        array.append(array.last()!)
        array.remove(array.last()!)
        
        XCTAssert(array == [1, 2, 3, 4])
    }

    func testUnique() {
        let arr = [1, 1, 1, 2, 3]
        XCTAssert(arr.unique() as Array<Int> == [1, 2, 3])
    }

    func testGroupBy() {
        let group = array.groupBy(groupingFunction: {
            (value: Int) -> Bool in
            return value > 3
        })

        XCTAssert(Array(group.keys) == [false, true])
        XCTAssert(Array(group[true]!) == [4, 5])
        XCTAssert(Array(group[false]!) == [1, 2, 3])
    }

    func testReduceRight () {
        let list = [[0, 1], [2, 3], [4, 5]];
        let flat = list.reduceRight(Array<Int>(), { return $0 + $1 });
        XCTAssert(flat == [4, 5, 2, 3, 0, 1])
    }

    func testImplode () {
        XCTAssert(["A", "B", "C"].implode("A") == "AABAC")
    }
    
    func testPluck () {

        let values = [
            ["Name": "Bob", "Score": 6],
            ["Name": "Tim", "Score": 8]
        ]

        let result = values.pluck("Score") as Int[]

        println(result)
        
    }

    /*
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            
        }
    }*/

}
