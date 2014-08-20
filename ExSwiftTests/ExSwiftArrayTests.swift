//
//  ExtensionsTests.swift
//  ExtensionsTests
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import XCTest

class ExtensionsArrayTests: XCTestCase {

    var array: [Int] = []
    var people: [(name: String, id: String)] = []
  
    override func setUp() {
        super.setUp()
        array = [1, 2, 3, 4, 5]

        let bob = (name: "bob", id: "P1")
        let frank = (name: "frank", id: "P2")
        let ian = (name: "ian", id: "P3")

        people = [bob, frank, ian]
    }

    func testSortBy () {
        var sourceArray = [2, 3, 6, 5]
        var sortedArray = sourceArray.sortBy {$0 < $1}

        // check that the source array as not been mutated
        XCTAssertEqual(sourceArray, [2, 3, 6, 5])
        // check that the destination has been sorted
        XCTAssertEqual(sortedArray, [2, 3, 5, 6])
    }
  
    func testReject () {
        var odd = array.reject({
            return $0 % 2 == 0
        })

        XCTAssertEqual(odd, [1, 3, 5])
    }
  
    func testToDictionary () {
        var dictionary = people.toDictionary { $0.id }
        
        XCTAssertTrue(Array(dictionary.keys).difference(["P3", "P1", "P2"]).isEmpty)
        
        XCTAssertEqual(dictionary["P1"]!.name, "bob")
        XCTAssertEqual(dictionary["P2"]!.name, "frank")
        XCTAssertEqual(dictionary["P3"]!.name, "ian")
    }
    
    func testEach() {
        var result = Array<Int>()

        array.each({
            result.append($0)
        })

        XCTAssertEqual(result, array)

        result.removeAll(keepCapacity: true)

        array.each({
            (index: Int, item: Int) in
            result.append(index)
        })

        XCTAssertEqual(result, array.map({ return $0 - 1 }) as Array<Int>)
    }

    func testEachRight() {
        var result = [Int]()
        
        array.eachRight { (index, value) -> () in
            result += [value]
        }
        
        XCTAssertEqual(result.first!, array.last!)
        XCTAssertEqual(result.last!, array.first!)
    }

    func testRange() {
        var range = Array<Int>.range(0..<2)
        XCTAssertEqual(range, [0, 1])
        
        range = Array<Int>.range(0...2)
        XCTAssertEqual(range, [0, 1, 2])
    }

    func testContains() {
        XCTAssertFalse(array.contains("A"))
        XCTAssertFalse(array.contains(6))
        XCTAssertTrue(array.contains(5))
        XCTAssertTrue(array.contains(3, 4) )
    }

    func testDifference() {
        var diff = array.difference([3, 4])
        XCTAssertEqual(diff, [1, 2, 5])
        
        diff = array - [3, 4]
        XCTAssertEqual(diff, [1, 2, 5])
        
        diff = array.difference([3], [5])
        XCTAssertEqual(diff, [1, 2, 4])
    }

    func testIndexOf() {
        //  Equatable parameter
        XCTAssertEqual(0, array.indexOf(1)!)
        XCTAssertEqual(3, array.indexOf(4)!)
        XCTAssertNil(array.indexOf(6))
        
        //  Matching block
        XCTAssertEqual(1, array.indexOf { item in
            return item % 2 == 0
        }!)
        XCTAssertNil(array.indexOf { item in
            return item > 10
        })
    }

    func testIntersection() {
        var intersection = array.intersection([Int]())
        XCTAssertEqual(intersection, [Int]())
        
        intersection = array.intersection([1])
        XCTAssertEqual(intersection, [1])
        
        intersection = array.intersection([1, 2], [1, 2], [1, 3])
        XCTAssertEqual(intersection, [1])
    }

    func testUnion() {
        var union = array.union([1])
        XCTAssertEqual(union, array)
        
        union = array.union(Array<Int>())
        XCTAssertEqual(union, array)
        
        union = array.union([6])
        XCTAssertEqual(union, [1, 2, 3, 4, 5, 6])
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

    func testPartition() {
        XCTAssertEqual(array.partition(2), [[1, 2], [3, 4]])
        XCTAssertEqual(array.partition(2, step: 1), [[1, 2], [2, 3], [3, 4], [4, 5]])
        XCTAssertEqual(array.partition(2, step: 1, pad: nil), [[1, 2], [2, 3], [3, 4], [4, 5], [5]])
        XCTAssertEqual(array.partition(4, step: 1, pad: nil), [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5]])
        XCTAssertEqual(array.partition(2, step: 1, pad: [6,7,8]), [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]])
        XCTAssertEqual(array.partition(4, step: 3, pad: [6]), [[1, 2, 3, 4], [4, 5, 6]])
        XCTAssertEqual(array.partition(2, pad: [6]), [[1, 2], [3, 4], [5, 6]])
        XCTAssertEqual([1, 2, 3, 4, 5, 6].partition(2, step: 4), [[1, 2], [5, 6]])
        XCTAssertEqual(array.partition(10), [[]])
    }
    
    func testPartitionAll() {
        XCTAssertEqual(array.partitionAll(2, step: 1), [[1, 2], [2, 3], [3, 4], [4, 5], [5]])
        XCTAssertEqual(array.partitionAll(2), [[1, 2], [3, 4], [5]])
        XCTAssertEqual(array.partitionAll(4, step: 1), [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5], [4, 5], [5]])
    }
    
    func testPartitionBy() {
        XCTAssertEqual(array.partitionBy { $0 > 10 }, [[1, 2, 3, 4, 5]])
        XCTAssertEqual([1, 2, 4, 3, 5, 6].partitionBy { $0 % 2 == 0 }, [[1], [2, 4], [3, 5], [6]])
        XCTAssertEqual([1, 7, 3, 6, 10, 12].partitionBy { $0 % 3 }, [[1, 7], [3, 6], [10], [12]])
    }
    
    func testSample() {
        XCTAssertEqual(1, array.sample().count)
        XCTAssertEqual(2, array.sample(size: 2).count)
        XCTAssertEqual(array.sample(size: array.count), array)
    }

    func testSubscript() {
        XCTAssertEqual(array[0..<0], [])
        XCTAssertEqual(array[0..<1], [1])
        XCTAssertEqual(array[0..<2], [1, 2])
        XCTAssertEqual(array[0...2], [1, 2, 3])
        XCTAssertEqual(array[0, 1, 2], [1, 2, 3])
    }

    func testShuffled() {
        let shuffled = array.shuffled()
        XCTAssertEqual(shuffled.difference(array), [])
        XCTAssertNotEqual(shuffled, array)
    }

    func testShuffle() {
        var toShuffle = array
        toShuffle.shuffle()
        XCTAssertEqual(toShuffle.difference(array), [])
    }

    func testMax() {
        XCTAssertEqual(5, array.max() as Int)
    }

    func testMin() {
        XCTAssertEqual(1, array.min() as Int)
    }

    func testTake() {
        XCTAssertEqual(array.take(3), [1, 2, 3])
        XCTAssertEqual(array.take(0), [])
    }
    
    func testTakeWhile() {
        XCTAssertEqual(array.takeWhile { $0 < 3 }, [1 , 2])
        XCTAssertEqual([1, 2, 3, 2, 1].takeWhile { $0 < 3 }, [1, 2])
        XCTAssertEqual(array.takeWhile { $0.isEven() }, [])
    }
    
    func testSkip() {
        XCTAssertEqual(array.skip(3), [4, 5])
        XCTAssertEqual(array.skip(0), array)
    }
    
    func testSkipWhile() {
        XCTAssertEqual(array.skipWhile { $0 < 3 }, [3, 4, 5])
        XCTAssertEqual([1, 2, 3, 2, 1].skipWhile { $0 < 3 }, [3, 2, 1])
        XCTAssertEqual(array.skipWhile { $0.isEven() }, array)
    }

    func testTail () {
        XCTAssertEqual(array.tail(3), [3, 4, 5])
        XCTAssertEqual(array.tail(0), [])
    }
    
    func testPop() {
        XCTAssertEqual(5, array.pop())
        XCTAssertEqual(array, [1, 2, 3, 4])
    }

    func testPush() {
        array.push(6)
        XCTAssertEqual(6, array.last!)
    }

    func testShift() {
        XCTAssertEqual(1, array.shift())
        XCTAssertEqual(array, [2, 3, 4, 5])
    }

    func testUnshift() {
        array.unshift(0)
        XCTAssertEqual(0, array.first!)
    }

    func testRemove() {
        array.append(array.last!)
        array.remove(array.last!)
        
        XCTAssertEqual((array - 1), [2, 3, 4])
        XCTAssertEqual(array, [1, 2, 3, 4])
    }

    func testUnique() {
        let arr = [1, 1, 1, 2, 3]
        XCTAssertEqual(arr.unique() as Array<Int>, [1, 2, 3])
    }

    func testGroupBy() {
        let group = array.groupBy(groupingFunction: {
            (value: Int) -> Bool in
            return value > 3
        })

        XCTAssertEqual(Array(group.keys), [false, true])
        XCTAssertEqual(Array(group[true]!), [4, 5])
        XCTAssertEqual(Array(group[false]!), [1, 2, 3])
    }

    func testCountBy() {
        let group = array.countBy(groupingFunction: {
            (value: Int) -> String in
            return value % 2 == 0 ? "even" : "odd"
        })

        XCTAssertEqual(group, ["even": 2, "odd": 3])
    }

    func testReduceRight () {
        let list = [[1, 1], [2, 3], [4, 5]]
        
        let flat = list.reduceRight([Int](), { return $0 + $1 })
        
        XCTAssertEqual(flat, [4, 5, 2, 3, 1, 1])
        
        XCTAssertEqual(16, flat.reduce(+)!)
        
        XCTAssertEqual(["A", "B", "C"].reduceRight(+)!, "CBA")
    }

    func testImplode () {
        let array = ["A", "B", "C"]
        
        var imploded = array.implode("A")
        XCTAssertEqual(imploded!, "AABAC")
        
        imploded = array * ","
        XCTAssertEqual(imploded!, "A,B,C")
    }
    
    func testAt () {
        XCTAssertEqual(array.at(0, 2), [1, 3])
        XCTAssertEqual(array[0, 2, 1], [1, 3, 2])
    }
    
    func testFlatten () {
        let array = [5, [6, [7]], 8]
        XCTAssertEqual(array.flatten() as [Int], [5, 6, 7, 8])
        XCTAssertEqual(array.flattenAny() as [Int], [5, 6, 7, 8])
    }
    
    func testGet () {
        XCTAssertEqual(1, array.get(0)!)
        XCTAssertEqual(array.get(-1)!, array.last!)
        XCTAssertEqual(array.get(array.count)!, array.first!)
    }

    func testDuplicationOperator () {
        XCTAssertEqual([1] * 3, [1, 1, 1])
    }
    
    func testLastIndexOf () {
        let array = [5, 1, 2, 3, 2, 1]
        
        XCTAssertEqual(array.count - 2, array.lastIndexOf(2)!)
        XCTAssertEqual(array.count - 1, array.lastIndexOf(1)!)
        XCTAssertEqual(0, array.lastIndexOf(5)!)
        
        XCTAssertNil(array.lastIndexOf(20))
    }
    
    func testInsert () {
        array.insert([0, 9], atIndex: 2)
        XCTAssertEqual(array, [1, 2, 0, 9, 3, 4, 5])
        
        //  Out of bounds indexes
        array.insert([10], atIndex: 10)
        XCTAssertEqual(array, [1, 2, 0, 9, 3, 4, 5, 10])
        
        array.insert([-2], atIndex: -1)
        XCTAssertEqual(array, [-2, 1, 2, 0, 9, 3, 4, 5, 10])
    }
    
    func testTakeFirst() {
        XCTAssertEqual(2, array.takeFirst { $0 % 2 == 0 }!)
        XCTAssertNil(array.takeFirst { $0 > 10 })
    }

    func testCountWhere() {
        XCTAssertEqual(2, array.countWhere { $0 % 2 == 0 })
    }

    func testMapFilter() {
        let m = array.mapFilter { value -> Int? in
            if value > 3 {
                return nil
            }
            
            return value + 1
        }
        
        XCTAssertEqual(m, [2, 3, 4])
    }
}
