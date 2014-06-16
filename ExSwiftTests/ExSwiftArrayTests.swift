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

    func testEachRight() {
        var result = Int[]()
        
        array.eachRight { (index: Int, value: Int) -> Void in
            result += value
        }

        XCTAssert(result.first() == array.last())
        XCTAssert(result.last() == array.first())
    }

    func testRange() {
        XCTAssert(Array<Int>.range(0..2) == [0, 1])
        XCTAssert(Array<Int>.range(0...2) == [0, 1, 2])
    }

    func testContains() {
        XCTAssertFalse(array.contains("A"))
        XCTAssertFalse(array.contains(6))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(3, 4) )
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
        XCTAssertEqual(0, array.indexOf(1)!)
        XCTAssertEqual(3, array.indexOf(4)!)
        XCTAssertNil(array.indexOf(6))
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
        XCTAssert(array.sample(size: array.count) == array)
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
    
    func testTakeWhile() {
        let descendingArray = [1, 2, 3, 2, 1] // FIXME: Cannot find member 'takeWhile' when comparing the results with == on unbound array. Bug reported.
        XCTAssert(array.takeWhile { $0 < 3 } == [1 , 2])
        XCTAssert(descendingArray.takeWhile { $0 < 3 } == [1, 2])
        XCTAssert(array.takeWhile { $0.isEven() } == [])
    }
    
    func testSkip() {
        XCTAssert(array.skip(3) == [4, 5])
        XCTAssert(array.skip(0) == array)
    }
    
    func testSkipWhile() {
        let descendingArray = [1, 2, 3, 2, 1] // FIXME: Cannot find member 'takeWhile' when comparing the results with == on unbound array. Bug reported.
        XCTAssert(array.skipWhile { $0 < 3 } == [3, 4, 5])
        XCTAssert(descendingArray.skipWhile { $0 < 3 } == [3, 2, 1])
        XCTAssert(array.skipWhile { $0.isEven() } == array)
    }

    func testTail () {
        XCTAssert(array.tail(3) == [3, 4, 5])
        XCTAssert(array.tail(0) == [])
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
        
        let diff = (array - 1)
        
        XCTAssert(diff == [2, 3, 4])
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

    func testCountBy() {
        let group = array.countBy(groupingFunction: {
            (value: Int) -> Bool in
            return value > 3
        })

        XCTAssert(group == [true: 2, false: 3])
    }

    func testReduceRight () {
        let list = [[1, 1], [2, 3], [4, 5]]
        let flat = list.reduceRight(Array<Int>(), { return $0 + $1 })
        
        XCTAssert(flat == [4, 5, 2, 3, 1, 1])
        XCTAssertEqual(4 + 5 + 2 + 3 + 1 + 1, flat.reduce(+))
        
        XCTAssert(["A", "B", "C"].reduceRight(+) == "CBA")
    }

    func testImplode () {
        XCTAssert(["A", "B", "C"].implode("A") == "AABAC")
        XCTAssert((["A", "B", "C"] * ",") == "A,B,C")
    }
    
    func testAt () {
        XCTAssert(array.at(0, 2) == [1, 3])
        XCTAssert(array[0, 2, 1] as Int[] == [1, 3, 2])
    }
    
    func testFlatten () {
        let array = [5, [6, [7]], 8]
        XCTAssert(array.flatten() as Int[] == [5, 6, 7, 8])
    }
    
    func testGet () {
        XCTAssertEqual(1, array.get(0)!)
        XCTAssertEqual(array.get(-1)!, array.last()!)
        XCTAssertEqual(array.get(array.count)!, array.first()!)
    }

    func testDuplicationOperator () {
        let _3times = (array * 3)
        XCTAssert(_3times == (array + array + array))
    }
    
    func testLastIndexOf () {
        let array = [5, 1, 2, 3, 2, 1]
        XCTAssertEqual(array.count - 2, array.lastIndexOf(2)!)
        XCTAssertEqual(array.count - 1, array.lastIndexOf(1)!)
        XCTAssertEqual(0, array.lastIndexOf(5)!)
        XCTAssertNil(array.lastIndexOf(20))
    }
}
