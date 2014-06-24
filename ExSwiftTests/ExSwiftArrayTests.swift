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
    var people: Person[] = []
  
    class Person {
        let name: String, age: Int, id: String
        init(_ name: String, _ age: Int, _ id: String){
            self.name = name
            self.age = age
            self.id = id
        }
    }

    override func setUp() {
        super.setUp()
        array = [1, 2, 3, 4, 5]
        people = [Person("bob", 25, "P1"),
            Person("frank", 45, "P2"),
            Person("ian", 35, "P3")];
    }

    func testSortBy () {
        var sourceArray = [2,3,6,5]
        var sortedArray = sourceArray.sortBy {$0 < $1}
        
        // check that the source array as not been mutated
        XCTAssertEqualObjects(sourceArray, [2, 3, 6, 5])
        // check that the destination has been sorted
        XCTAssertEqualObjects(sortedArray, [2, 3, 5, 6])
    }
  
    func testReject () {
        var odd = array.reject({
            return $0 % 2 == 0
        })

        XCTAssertEqualObjects(odd, [1, 3, 5])
    }
  
    func testToDictionary () {
        var dictionary = people.toDictionary { $0.id }
        
        XCTAssertEqualObjects(Array(dictionary.keys), ["P3", "P1", "P2"])
        XCTAssertEqualObjects(dictionary["P1"]?.name, "bob")
        XCTAssertEqualObjects(dictionary["P2"]?.name, "frank")
        XCTAssertEqualObjects(dictionary["P3"]?.name, "ian")
    }

    func testEach() {
        var result = Array<Int>()

        array.each({
            result.append($0)
        })

        XCTAssertEqualObjects(result, array)

        result.removeAll(keepCapacity: true)

        array.each({
            (index: Int, item: Int) in
            result.append(index)
        })

        XCTAssertEqualObjects(result, array.map({ return $0 - 1 }) as Int[])
    }

    func testEachRight() {
        var result = Int[]()
        
        array.eachRight { (index: Int, value: Int) -> Void in
            result += value
        }

        XCTAssertEqualObjects(result.first(), array.last())
        XCTAssertEqualObjects(result.last(), array.first())
    }

    func testRange() {
        XCTAssertEqualObjects(Array<Int>.range(0..2), [0, 1])
        XCTAssertEqualObjects(Array<Int>.range(0...2), [0, 1, 2])
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
        XCTAssertEqualObjects(array.difference([3, 4]), [1, 2, 5])
        XCTAssertEqualObjects(array - [3, 4], [1, 2, 5])
        XCTAssertEqualObjects(array.difference([3], [5]), [1, 2, 4])
    }

    func testIndexOf() {
        XCTAssertEqual(0, array.indexOf(1)!)
        XCTAssertEqual(3, array.indexOf(4)!)
        XCTAssertNil(array.indexOf(6))
    }

    func testIntersection() {
        XCTAssertEqualObjects(array.intersection([]), [])
        XCTAssertEqualObjects(array.intersection([1]), [1])
        XCTAssertEqualObjects(array.intersection([1, 2], [1, 2], [1, 3]), [1])
    }

    func testUnion() {
        XCTAssertEqualObjects(array.union([1]), array)
        XCTAssertEqualObjects(array.union(Int[]()), array)
        XCTAssertEqualObjects(array.union([6]), [1, 2, 3, 4, 5, 6])
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
        XCTAssertEqualObjects(array.partition(2), [[1, 2], [3, 4]])
        XCTAssertEqualObjects(array.partition(2, step: 1), [[1, 2], [2, 3], [3, 4], [4, 5]])
        XCTAssertEqualObjects(array.partition(2, step: 1, pad: nil), [[1, 2], [2, 3], [3, 4], [4, 5], [5]])
        XCTAssertEqualObjects(array.partition(4, step: 1, pad: nil), [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5]])
        XCTAssertEqualObjects(array.partition(2, step: 1, pad: [6,7,8]), [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]])
        XCTAssertEqualObjects(array.partition(4, step: 3, pad: [6]), [[1, 2, 3, 4], [4, 5, 6]])
        XCTAssertEqualObjects(array.partition(2, pad: [6]), [[1, 2], [3, 4], [5, 6]])
        XCTAssertEqualObjects([1, 2, 3, 4, 5, 6].partition(2, step: 4), [[1, 2], [5, 6]])
        XCTAssertEqualObjects(array.partition(10), [[]])
    }
    
    func testPartitionAll() {
        XCTAssertEqualObjects(array.partitionAll(2, step: 1), [[1, 2], [2, 3], [3, 4], [4, 5], [5]])
        XCTAssertEqualObjects(array.partitionAll(2), [[1, 2], [3, 4], [5]])
        XCTAssertEqualObjects(array.partitionAll(4, step: 1), [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5], [4, 5], [5]])
    }
    
    func testPartitionBy() {
        XCTAssertEqualObjects(array.partitionBy { $0 > 10 }, [[1, 2, 3, 4, 5]])
        XCTAssertEqualObjects([1, 2, 4, 3, 5, 6].partitionBy { $0 % 2 == 0 }, [[1], [2, 4], [3, 5], [6]])
        XCTAssertEqualObjects([1, 7, 3, 6, 10, 12].partitionBy { $0 % 3 }, [[1, 7], [3, 6], [10], [12]])
    }
    
    func testSample() {
        XCTAssertEqual(1, array.sample().count)
        XCTAssertEqual(2, array.sample(size: 2).count)
        XCTAssertEqualObjects(array.sample(size: array.count), array)
    }

    func testSubscriptRange() {
        XCTAssertEqualObjects(array[0..0], [])
        XCTAssertEqualObjects(array[0..1], [1])
        XCTAssertEqualObjects(array[0..2], [1, 2])
    }

    func testShuffled() {
        let shuffled = array.shuffled()
        XCTAssertEqualObjects(shuffled.difference(array), [])
    }

    func testShuffle() {
        var toShuffle = array.copy()
        toShuffle.shuffle()
        XCTAssertEqualObjects(toShuffle.difference(array), [])
    }

    func testMax() {
        XCTAssertEqual(5, array.max() as Int)
    }

    func testMin() {
        XCTAssertEqual(1, array.min() as Int)
    }

    func testTake() {
        XCTAssertEqualObjects(array.take(3), [1, 2, 3])
        XCTAssertEqualObjects(array.take(0), [])
    }
    
    func testTakeWhile() {
        XCTAssertEqualObjects(array.takeWhile { $0 < 3 }, [1 , 2])
        XCTAssertEqualObjects([1, 2, 3, 2, 1].takeWhile { $0 < 3 }, [1, 2])
        XCTAssertEqualObjects(array.takeWhile { $0.isEven() }, [])
    }
    
    func testSkip() {
        XCTAssertEqualObjects(array.skip(3), [4, 5])
        XCTAssertEqualObjects(array.skip(0), array)
    }
    
    func testSkipWhile() {
        XCTAssertEqualObjects(array.skipWhile { $0 < 3 }, [3, 4, 5])
        XCTAssertEqualObjects([1, 2, 3, 2, 1].skipWhile { $0 < 3 }, [3, 2, 1])
        XCTAssertEqualObjects(array.skipWhile { $0.isEven() }, array)
    }

    func testTail () {
        XCTAssertEqualObjects(array.tail(3), [3, 4, 5])
        XCTAssertEqualObjects(array.tail(0), [])
    }
    
    func testPop() {
        XCTAssertEqual(5, array.pop())
        XCTAssertEqualObjects(array, [1, 2, 3, 4])
    }

    func testPush() {
        array.push(6)
        XCTAssertEqual(6, array.last()!)
    }

    func testShift() {
        XCTAssertEqual(1, array.shift())
        XCTAssertEqualObjects(array, [2, 3, 4, 5])
    }

    func testUnshift() {
        array.unshift(0)
        XCTAssertEqual(0, array.first()!)
    }

    func testRemove() {
        array.append(array.last()!)
        array.remove(array.last()!)
        
        XCTAssertEqualObjects((array - 1), [2, 3, 4])
        XCTAssertEqualObjects(array, [1, 2, 3, 4])
    }

    func testUnique() {
        let arr = [1, 1, 1, 2, 3]
        XCTAssertEqualObjects(arr.unique() as Int[], [1, 2, 3])
    }

    func testGroupBy() {
        let group = array.groupBy(groupingFunction: {
            (value: Int) -> Bool in
            return value > 3
        })

        XCTAssertEqualObjects(Array(group.keys), [false, true])
        XCTAssertEqualObjects(Array(group[true]!), [4, 5])
        XCTAssertEqualObjects(Array(group[false]!), [1, 2, 3])
    }

    func testCountBy() {
        let group = array.countBy(groupingFunction: {
            (value: Int) -> Bool in
            return value > 3
        })

        XCTAssertEqualObjects(group, [true: 2, false: 3])
    }

    func testReduceRight () {
        let list = [[1, 1], [2, 3], [4, 5]]
        let flat = list.reduceRight(Array<Int>(), { return $0 + $1 })
        
        XCTAssertEqualObjects(flat, [4, 5, 2, 3, 1, 1])
        XCTAssertEqual(4 + 5 + 2 + 3 + 1 + 1, flat.reduce(+))
        
        XCTAssertEqualObjects(["A", "B", "C"].reduceRight(+), "CBA")
    }

    func testImplode () {
        let array = ["A", "B", "C"]
        let imploded = array.implode("A")
        XCTAssertEqualObjects(imploded!, "AABAC")
        XCTAssertEqualObjects(array * ",", "A,B,C")
    }
    
    func testAt () {
        XCTAssertEqualObjects(array.at(0, 2), [1, 3])
        XCTAssertEqualObjects(array[0, 2, 1] as Int[], [1, 3, 2])
    }
    
    func testFlatten () {
        let array = [5, [6, [7]], 8]
        XCTAssertEqualObjects(array.flatten() as Int[], [5, 6, 7, 8])
    }
    
    func testGet () {
        XCTAssertEqual(1, array.get(0)!)
        XCTAssertEqual(array.get(-1)!, array.last()!)
        XCTAssertEqual(array.get(array.count)!, array.first()!)
    }

    func testDuplicationOperator () {
        XCTAssertEqualObjects(array * 3, (array + array + array))
    }
    
    func testLastIndexOf () {
        let array = [5, 1, 2, 3, 2, 1]
        XCTAssertEqual(array.count - 2, array.lastIndexOf(2)!)
        XCTAssertEqual(array.count - 1, array.lastIndexOf(1)!)
        XCTAssertEqual(0, array.lastIndexOf(5)!)
        XCTAssertNil(array.lastIndexOf(20))
    }
}
