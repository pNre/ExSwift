//
//  ArrayExtensionsTests.swift
//  ExtensionsTests
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class ArrayExtensionsSpec: QuickSpec {
    
    var intArray: [Int] = []
    var stringArray: [String] = []
    
    override func spec() {
        
        beforeEach { () -> () in
            
            self.intArray = [Int](1...5)
            self.stringArray = ["A", "B", "C", "D", "E", "F"]
            
        }
        
        /**
        *  Array.get
        */
        describe("get") {
            
            it("in bounds") {
                
                for i in enumerate(self.intArray) {
                    expect(self.intArray.get(i.index)) == (i.element)
                }
                
            }
            
            it("out of bounds") {
                
                expect(self.intArray.get(-1)).to(beNil())
                
                expect(self.intArray.get(self.intArray.count)).to(beNil())
                
            }

        }
        
        /**
        *  Array.sortUsing
        */
        describe("sortUsing") {
            
            it("default item comparison") {
                
                expect(self.intArray.sortUsing { $0 }) == [1, 2, 3, 4, 5]
                
            }
            
            it("mapped item") {
                
                expect(self.intArray.sortUsing { $0 % 2 }) == [2, 4, 1, 3, 5]
                expect(self.intArray.sortUsing { -$0 }) == self.intArray.reverse()
                
            }
            
        }
        
        /**
        *  Array.reject
        */
        describe("reject") {
            
            it("all/none") {
                
                expect(self.intArray.reject { _ in true }) == []
                
                expect(self.intArray.reject { _ in false }) == self.intArray
                
            }
            
            it("misc") {
                
                expect(self.intArray.reject { obj in obj > 3 }) == [1, 2, 3]
                
                expect(self.intArray.reject { obj in obj % 2 == 0 }) == [1, 3, 5]
                
            }
            
        }
        
        /**
        *  Array.each
        */
        describe("each") {
            
            it("object param") {
                
                var data = [Int]()
                
                self.intArray.each { data.append($0) }
                
                expect(data) == self.intArray
                
            }
            
            it("index param") {
                
                var data = [Int]()
                
                self.intArray.each { index, obj in data.append(index) }
                
                expect(data) == [Int](0...4)
                
            }
            
        }
        
        /**
        *  Array.contains
        */
        describe("contains") {
            
            it("one item") {
                
                expect(self.intArray.contains(10)).to(beFalse())
                
                expect(self.intArray.contains(4)).to(beTrue())
                
            }
            
            it("more than one item") {
                
                //  Contains 1, doesn't contain 10
                expect(self.intArray.contains(1, 10)).to(beFalse())
                
                //  Contains both 1, 2
                expect(self.intArray.contains(1, 2)).to(beTrue())
                
                //  Doesn't contain 6, 7, 8
                expect(self.intArray.contains(6, 7, 8)).to(beFalse())
                
            }
            
            it("item of an invalid type") {
                
                expect(self.intArray.contains("A")).to(beFalse())
                
            }
            
        }
        
        /**
        *  Array.indexOf
        */
        describe("indexOf") {
            
            it("with an object") {
                
                expect(self.intArray.indexOf(1)) == 0
                expect(self.intArray.indexOf(5)) == 4
                
                expect(self.intArray.indexOf(self.intArray[2])) == 2
                
                expect(self.intArray.indexOf(50)).to(beNil())
                
            }
            
            it("with matching block") {
                
                expect(self.intArray.indexOf { $0 % 2 == 0 }) == 1
                
                expect(self.intArray.indexOf { $0 > 10 }).to(beNil())
                
            }
            
        }
        
        /**
        *  Array.lastIndexOf
        */
        describe("lastIndexOf") {
            
            var arrayWithDuplicates: [Int] = []
            
            beforeEach {
                
                arrayWithDuplicates = [1, 1, 2, 2, 3, 4, 1]
                
            }
            
            it("with an object") {
                
                expect(arrayWithDuplicates.lastIndexOf(1)) == 6
                expect(arrayWithDuplicates.lastIndexOf(4)) == 5
                
                expect(arrayWithDuplicates.lastIndexOf(arrayWithDuplicates[2])) == 3
                
                expect(arrayWithDuplicates.lastIndexOf(50)).to(beNil())
                
            }
            
        }
        
        /**
        *  Array.max
        */
        describe("max") {
            
            it("comparable array") {
                
                expect(self.intArray.max() as Int) == 5
                
            }
            
        }
        
        /**
        *  Array.min
        */
        describe("min") {
            
            it("comparable array") {
                
                expect(self.intArray.min() as Int) == 1
                
            }
            
        }
        
        /**
        *  Array.at
        */
        describe("at") {
            
            it("at") {
                
                expect(self.intArray.at(0, 2)) == [1, 3]
                
            }
            
            it("subscript") {
                
                expect(self.intArray[0, 2, 1]) == [1, 3, 2]
                
            }
            
        }

        /**
        *  Array.unique/uniqueBy
        */
        describe("unique/uniqueBy") {
            
            var arrayWithDuplicates: [Int] = []
            
            beforeEach {
                
                arrayWithDuplicates = [1, 1, 2, 2, 3, 4]
                
            }
            
            it("unique") {
                
                expect(arrayWithDuplicates.unique() as [Int]) == [1, 2, 3, 4]
                
            }
            
            it("uniqueBy") {
            
                expect(arrayWithDuplicates.uniqueBy { $0 }) == arrayWithDuplicates.unique()
                
                expect(arrayWithDuplicates.uniqueBy { $0 % 2 }) == [1, 2]
                
                expect(arrayWithDuplicates.uniqueBy { $0 % 3 }) == [1, 2, 3]
                
                expect(arrayWithDuplicates.uniqueBy { $0 < 3 }) == [1, 3]
                
            }
            
        }
        
        /**
        *  Array.take/takeWhile
        */
        describe("take/takeWhile") {
            
            it("take") {
                
                expect(self.intArray.take(2)) == self.intArray[0..2]
                expect(self.intArray.take(0)) == []
                
            }
            
            it("take out of bounds") {
                
                expect(self.intArray.take(6)) == self.intArray
                expect(self.intArray.take(-1)) == []
                
            }
            
            it("takeWhile") {
                
                expect(self.intArray.takeWhile { $0 < 3 }) == [1, 2]
                
                expect(self.intArray.takeWhile { $0 % 2 == 0 }) == []
                
            }
            
        }
        
        /**
        *  Array.skip/skipWhile
        */
        describe("skip/skipWhile") {
            
            it("skip") {
                
                expect(self.intArray.skip(2)) == self.intArray[2..<self.intArray.count]
                expect(self.intArray.skip(0)) == self.intArray
                
            }
            
            it("skip out of bounds") {
                
                expect(self.intArray.skip(6)) == []
                expect(self.intArray.skip(-1)) == self.intArray
                
            }
            
            it("skipWhile") {
                
                expect(self.intArray.skipWhile { $0 < 3 }) == [3, 4, 5]
                
                expect(self.intArray.skipWhile { $0 % 2 == 0 }) == self.intArray
                
                expect(self.intArray.skipWhile { $0 > 0 }) == []
                
            }
            
        }
        
        /**
        *  Array.countBy
        */
        describe("countBy") {
            
            it("countBy") {
                
                let count_1 = self.intArray.countBy {
                    return $0 % 2 == 0 ? "even" : "odd"
                }
                
                expect(count_1) == ["even": 2, "odd": 3]
                
                let count_2 = self.intArray.countBy { param -> Int in
                    return 0
                }
                
                expect(count_2) == [0: self.intArray.count]
                
            }
            
        }

        /**
        *   Array.difference
        */
        describe("difference") {
            
            it("method") {
                
                expect(self.intArray.difference([3, 4])) == [1, 2, 5]
                
                expect(self.intArray.difference([3], [4])) == [1, 2, 5]
                
                expect(self.intArray.difference([])) == self.intArray
                
            }
            
            it("operator") {
                
                expect(self.intArray - [3, 4]) == [1, 2, 5]
                
                expect(self.intArray - [3] - [4]) == [1, 2, 5]
                
                expect(self.intArray - []) == self.intArray
                
            }
            
        }
        
        /**
        *   Array.intersection
        */
        describe("intersection") {
        
            it("method") {
                
                expect(self.intArray.intersection([])) == []
            
                expect(self.intArray.intersection([1])) == [1]
                
                expect(self.intArray.intersection([1, 2], [1, 2], [1, 2, 3])) == [1, 2]
            
            }
            
            it("operator") {
                
                expect(self.intArray & []) == []
                
                expect(self.intArray & [1]) == [1]

                expect(self.intArray & [1, 2] & [1, 2] & [1, 2, 3]) == [1, 2]
            
            }
            
        }
        
        /**
        *   Array.union
        */
        describe("union") {
            
            it("method") {
                
                expect(self.intArray.union([])) == self.intArray
                
                expect(self.intArray.union([1])) == self.intArray
                
                expect(self.intArray.union([1, 5], [6], [7, 4])) == [1, 2, 3, 4, 5, 6, 7]
                
            }
            
            it("operator") {
                
                expect(self.intArray | []) == self.intArray
                
                expect(self.intArray | [1]) == self.intArray
                
                expect(self.intArray | [1, 5] | [6] | [7, 4]) == [1, 2, 3, 4, 5, 6, 7]
                
            }
            
        }
        
        /**
        *  Array duplication
        */
        describe("duplication") {
            
            it("operator") {
                
                expect([1] * 3) == [1, 1, 1]
                
                expect(self.intArray * 0) == []
                expect(self.intArray * 1) == self.intArray
                
            }
            
        }
        
        /**
        *  Array.tail
        */
        describe("tail") {
            
            it("in bounds") {
                
                expect(self.intArray.tail(0)) == []
                
                expect(self.intArray.tail(3)) == [3, 4, 5]
                
            }
            
            it("out of bounds") {
                
                expect(self.intArray.tail(10)) == self.intArray
                
            }
            
        }
        
        /**
        *  Array.pop
        */
        describe("pop") {
            
            it("non empty array") {
                
                expect(self.intArray.pop()) == 5
                expect(self.intArray) == [1, 2, 3, 4]
                
            }
            
            it("empty array") {
                
                var emptyArray = [Int]()
                
                expect(emptyArray.pop()).to(beNil())
                
            }
            
        }
        
        /**
        *  Array.push
        */
        describe("push") {
            
            it("push") {
                
                self.intArray.push(10)
                
                expect(self.intArray.last) == 10
                
            }
            
        }
        
        /**
        *  Array.shift
        */
        describe("shift") {
        
            it("non empty array") {
                
                expect(self.intArray.shift()) == 1
                expect(self.intArray) == [2, 3, 4, 5]
                
            }
            
            it("empty array") {
                
                var emptyArray = [Int]()
                
                expect(emptyArray.shift()).to(beNil())
                
            }
            
        }
        
        /**
        *  Array.unshift
        */
        describe("unshift") {
            
            it("unshift") {
                
                self.intArray.unshift(10)
                
                expect(self.intArray) == [10, 1, 2, 3, 4, 5]
                
            }

        }
        
        /**
        *  Array.remove
        */
        describe("remove") {
            
            it("method") {
                
                self.intArray.remove(1)
                
                expect(self.intArray) == [2, 3, 4, 5]
                
                self.intArray.remove(6)
                
                expect(self.intArray) == [2, 3, 4, 5]
                
            }
            
            it("operator") {
                
                expect(self.intArray - 1) == [2, 3, 4, 5]
                
                expect(self.intArray - 6) == [1, 2, 3, 4, 5]

            }
        }

        /**
        *  Array.toDictionary
        */
        describe("toDictionary") {
            
            it("map values to keys") {
                
                let dictionary = self.intArray.toDictionary {
                    
                    return "Number \($0)"
                    
                }
                
                for i in enumerate(self.intArray) {
                    
                    expect(dictionary["Number \(i.element)"]) == i.element
                    
                }
                
            }
            
            it("map keys and values") {
                
                let dictionary = self.intArray.toDictionary { (element) -> (Int, String)? in
                    
                    if (element > 2) {
                        return nil
                    }
                    
                    return (element, "Number \(element)")
                    
                }
                
                expect(dictionary[1]) == "Number 1"
                expect(dictionary[2]) == "Number 2"
                
                expect(dictionary.keys.array - [1, 2]) == []
                
            }
            
        }
        
        /**
        *  Array.implode
        */
        describe("implode") {
        
            it("method") {
                
                expect(self.stringArray.implode("")) == "ABCDEF"
                expect(self.stringArray.implode("*")) == "A*B*C*D*E*F"

            }
            
            it("operator") {
                
                expect(self.stringArray * "") == "ABCDEF"
                expect(self.stringArray * "*") == "A*B*C*D*E*F"
                
            }
            
        }
        
        /**
         *  Array.flatten
         */
        describe("flatten") {
        
            var multidimensionalArray: NSArray = []
        
            beforeEach { () -> () in
                
                multidimensionalArray = [5, [6, [7]], 8]
                
            }
        
            it("flatten") {
    
                expect(multidimensionalArray.flatten() as [Int]) == [5, 6, 7, 8]
                expect((multidimensionalArray.flattenAny() as! [Int])) == [5, 6, 7, 8]
    
            }
        
        }
        
        /**
        *  Array.minBy
        */
        it("minBy") {
            
            expect(self.intArray.minBy { $0 }) == 1
            
            expect(self.intArray.minBy { -$0 }) == 5
            
            expect(self.intArray.minBy { $0 % 4 }) == 4
            
            expect(self.intArray.minBy { $0 % 2 }) == 2

        }
        
        /**
        *  Array.maxBy
        */
        it("maxBy") {
            
            expect(self.intArray.maxBy { $0 }) == 5
            
            expect(self.intArray.maxBy { -$0 }) == 1
            
            expect(self.intArray.maxBy { $0 % 4 }) == 3
            
            expect(self.intArray.maxBy { $0 % 3 }) == 2
            
        }

        /**
        *  Array.zip
        */
        it("zip") {
            
            let zipped = self.stringArray.zip(self.intArray)
            
            expect(zipped[0].first as? String) == "A"
            expect(zipped[0].last as? Int) == 1
            
            expect(zipped[1].first as? String) == "B"
            expect(zipped[1].last as? Int) == 2
            
            expect(zipped.last!.first as? String) == "E"
            expect(zipped.last!.last as? Int) == 5
            
        }

        /**
        *  Array.sample
        */
        it("sample") {

            //  0 objects
            let zero = self.intArray.sample(size: 0)
            
            expect(zero).to(beEmpty())
            
            //  1 object
            let one = self.intArray.sample()[0]
            
            expect(self.intArray).to(contain(one))
            
            //  n > 1 objects
            let sampled = self.intArray.sample(size: 3)

            for item in sampled {
                expect(self.intArray).to(contain(item))
            }
            
        }
        
        /**
        *  Array.groupBy
        */
        it("groupBy") {
            
            let group = self.intArray.groupBy(groupingFunction: {
                (value: Int) -> Bool in
                return value > 3
            })
                
            expect(group.keys.array) == [false, true]
                
            expect(group[true]) == [4, 5]
            expect(group[false]) == [1, 2, 3]
                
        }
        
        /**
         *  Array.countWhere
         */
        it("countWhere") {
            
            expect(self.intArray.countWhere { value in true }) == self.intArray.count
            expect(self.intArray.countWhere { value in false }) == 0

            expect(self.intArray.countWhere { value in value % 2 == 0 }) == 2

        }
        
        /**
        *  Array.takeFirst
        */
        it("takeFirst") {
            
            expect(self.intArray.takeFirst { value in true }) == 1
            expect(self.intArray.takeFirst { value in false }).to(beNil())
            
            expect(self.intArray.takeFirst { $0 % 2 == 0 }) == 2
            expect(self.intArray.takeFirst { $0 > 10 }).to(beNil())
            
        }
        
        /**
        *  Array.fill
        */
        it("fill") {
            
            self.intArray.fill(0)
            
            for object in self.intArray {
                expect(object) == 0
            }
            
            var emptyArray: [String] = []
            emptyArray.fill("x")
            
            expect(emptyArray) == []
            
        }
        
        /**
        *  Array.insert
        */
        it("insert") {
            
            self.intArray.insert([6, 7, 8], atIndex: 1)
            
            expect(self.intArray) == [1, 6, 7, 8, 2, 3, 4, 5]
            
            self.intArray.insert([9], atIndex: 10)
            
            expect(self.intArray) == [1, 6, 7, 8, 2, 3, 4, 5, 9]
            
            self.intArray.insert([0], atIndex: -2)
            
            expect(self.intArray) == [0, 1, 6, 7, 8, 2, 3, 4, 5, 9]
            
        }
        
        /**
        *  Array[]
        */
        describe("subscript") {
            
            it("half open interval") {
                
                expect(self.intArray[0..<0]) == []
                expect(self.intArray[0..<1]) == [1]
                expect(self.intArray[0..<2]) == [1, 2]

            }
            
            it("interval") {
                
                expect(self.intArray[0...0]) == [1]
                expect(self.intArray[0...1]) == [1, 2]
                expect(self.intArray[0...2]) == [1, 2, 3]
                
            }
            
            it("list of indices") {
                
                expect(self.intArray[0, 1]) == [1, 2]
                expect(self.intArray[2, 4]) == [3, 5]
                
            }
            
        }
        
        /**
        *  Array.shuffled
        */
        it("shuffled") {
            
            expect(self.intArray - self.intArray.shuffled()) == []
        
        }
        
        /**
        *  Array.shuffle
        */
        it("shuffled") {
            
            var array = self.intArray
            
            self.intArray.shuffle()
            
            expect(self.intArray - array) == []
            
        }
        
        /**
        *  Array.mapFilter
        */
        it("mapFilter") {
            
            let mapped = self.intArray.mapFilter { value in
                return value > 3 ? nil : value + 1
            }
            
            expect(mapped) == [2, 3, 4]
            
        }
        
        /**
        *  Array.mapAccum
        */
        it("mapAccum") {
            
            let (accumulated, mapped) = self.intArray.mapAccum(0) { accumulator, value in
                return (accumulator + value, value - 1)
            }
            
            expect(accumulated) == self.intArray.reduce(+)
            expect(mapped) == self.intArray.map { $0 - 1 }
            
        }
        
        /**
        *  Array.cycle
        */
        it("cycle") {
        
            var sum = 0
            
            self.intArray.cycle(n: 2) {
                sum += $0
            }
        
            expect(sum) == self.intArray.reduce(0, combine: +) * 2
        
            sum = 0
            
            self.intArray.cycle(n: 0) {
                sum += $0
            }
            
            expect(sum) == 0
            
            self.intArray.cycle(n: -1) {
                sum += $0
            }
            
            expect(sum) == 0

        }
        
        /**
        *  Array.partition
        */
        it("partition") {
            
            expect(self.intArray.partition(2)) == [[1, 2], [3, 4]]
            
            expect(self.intArray.partition(2, step: 1)) == [[1, 2], [2, 3], [3, 4], [4, 5]]
            
            expect(self.intArray.partition(2, step: 1, pad: nil)) == [[1, 2], [2, 3], [3, 4], [4, 5], [5]]
            expect(self.intArray.partition(4, step: 1, pad: nil)) == [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5]]
            
            expect(self.intArray.partition(2, step: 1, pad: [6, 7, 8])) == [[1, 2], [2, 3], [3, 4], [4, 5], [5, 6]]
            expect(self.intArray.partition(4, step: 3, pad: [6])) == [[1, 2, 3, 4], [4, 5, 6]]
            
            expect(self.intArray.partition(2, pad: [6])) == [[1, 2], [3, 4], [5, 6]]
            
            expect([1, 2, 3, 4, 5, 6].partition(2, step: 4)) == [[1, 2], [5, 6]]
            
            expect(self.intArray.partition(10)) == [[]]

        }
        
        /**
        *  Array.partitionAll
        */
        it("partitionAll") {
        
            expect(self.intArray.partitionAll(2, step: 1)) == [[1, 2], [2, 3], [3, 4], [4, 5], [5]]
            
            expect(self.intArray.partitionAll(2)) == [[1, 2], [3, 4], [5]]
            
            expect(self.intArray.partitionAll(4, step: 1)) == [[1, 2, 3, 4], [2, 3, 4, 5], [3, 4, 5], [4, 5], [5]]
            
        }
        
        /**
        *  Array.partitionBy
        */
        it("partitionBy") {
            
            expect(self.intArray.partitionBy { value in false }) == [self.intArray]
            expect(self.intArray.partitionBy { value in true }) == [self.intArray]
            
            expect([1, 2, 4, 3, 5, 6].partitionBy { $0 % 2 == 0 }) == [[1], [2, 4], [3, 5], [6]]
            
            expect([1, 7, 3, 6, 10, 12].partitionBy { $0 % 3 }) == [[1, 7], [3, 6], [10], [12]]
            
        }
        
        /**
        *  Array.repeatedCombination
        */
        it("repeatedCombination") {
            
            var array = [1, 2, 3]
            
            expect(array.repeatedCombination(-1)) == []
            
            expect(array.repeatedCombination(0)) == [[]]
            
            expect(array.repeatedCombination(1)) == [[1], [2], [3]]
            expect(array.repeatedCombination(2)) == [[1, 1], [1, 2], [1, 3], [2, 2], [2, 3], [3, 3]]
            expect(array.repeatedCombination(3)) == [[1, 1, 1],[1, 1, 2], [1, 1, 3], [1, 2, 2], [1, 2, 3], [1, 3, 3], [2, 2, 2], [2, 2, 3], [2, 3, 3], [3, 3, 3]]
            expect(array.repeatedCombination(4)) == [[1, 1, 1, 1], [1, 1, 1, 2], [1, 1, 1, 3], [1, 1, 2, 2], [1, 1, 2, 3],  [1, 1, 3, 3], [1, 2, 2, 2], [1, 2, 2, 3], [1, 2, 3, 3], [1, 3, 3, 3], [2, 2, 2, 2], [2, 2, 2, 3], [2, 2, 3, 3], [2, 3, 3, 3], [3, 3, 3, 3]]

        }
        
        /**
        *  Array.combination
        */
        it("combination") {
        
            expect(self.intArray.combination(-1)) == []
            
            expect(self.intArray.combination(0)) == [[]]
            
            expect(self.intArray.combination(1)) == [[1], [2], [3], [4], [5]]
            expect(self.intArray.combination(2)) == [[1, 2], [1, 3], [1, 4], [1, 5], [2, 3], [2, 4], [2, 5], [3, 4], [3, 5], [4, 5]]
            expect(self.intArray.combination(3)) == [[1, 2, 3], [1, 2, 4], [1, 2, 5], [1, 3, 4], [1, 3, 5], [1, 4, 5], [2, 3, 4], [2, 3, 5], [2, 4, 5], [3, 4, 5]]
            expect(self.intArray.combination(4)) == [[1, 2, 3, 4], [1, 2, 3, 5], [1, 2, 4, 5], [1, 3, 4, 5], [2, 3, 4, 5]]
            expect(self.intArray.combination(5)) == [[1, 2, 3, 4, 5]]
            expect(self.intArray.combination(6)) == []
            
        }
        
        /**
        *  Array.transposition
        */
        it("transposition") {
        
            var arrays: [[Int]] = [self.intArray] * self.intArray.count
            
            var arraysTransposition: [[Int]] = [].transposition(arrays)
            arrays.eachIndex { i in
                arrays[0].eachIndex { j in
                    expect(arrays[i][j]) == arraysTransposition[j][i]
                }
            }
            
            var jagged: [[String]] = [["a", "b", "c"], ["d", "e"], ["f", "g", "h"]]
            var jaggedTransposition = [].transposition(jagged)
            
            expect(jaggedTransposition) == [["a", "d", "f"], ["b", "e", "g"], ["c", "h"]]
            
        }
        
        /**
        *  Array.permutation
        */
        it("permutation") {
        
            1.upTo(self.intArray.count) { i in
                var permutations: [[Int]] = self.intArray.permutation(i)
                var factorial = 1
                
                for j in 1...i {
                    factorial *= j
                }
                
                expect(permutations.count) == self.intArray.combination(i).count * factorial
                
                var mappedPermutations: [Int] = permutations.map({ (i: [Int]) -> [Int] in i.unique()}).flatten()
                var flattenedPermutations: [Int] = permutations.flatten()
                
                expect(mappedPermutations) == flattenedPermutations
                expect(permutations.flatten().all({$0 >= 1 && $0 <= 5})).to(beTrue())
                expect(permutations.unique()) == permutations
            }
            
            expect(self.intArray.permutation(-1)) == []
            expect(self.intArray.permutation(0)) == [[]]
            expect(self.intArray.permutation(self.intArray.count + 1)) == []

        }
        
        /**
        *  Array.repeatedPermutation
        */
        it("repeatedPermutation") {
        
            var shortArray = [1, 2]
            
            expect(shortArray.repeatedPermutation(0)) == []
            expect(shortArray.repeatedPermutation(1)) == [[1], [2]]
            expect(shortArray.repeatedPermutation(2)) == [[1, 1], [1, 2], [2, 1], [2, 2]]
            expect(shortArray.repeatedPermutation(3)) == [[1, 1, 1], [1, 1, 2], [1, 2, 1], [1, 2, 2], [2, 1, 1], [2, 1, 2], [2, 2, 1], [2, 2, 2]]

        }
        
        /**
        *  Array.bSearch
        */
        describe("bSearch") {
        
            it("findMin") {
                
                1.upTo(10) { arraySize in
                
                    var testArray: [Int] = []
                    
                    1.upTo(arraySize) { i in
                        testArray += [i]
                    }

                    for i in testArray {
                        expect(testArray.bSearch({ $0 >= i })) == i
                    }
                    
                }
                
                expect(self.intArray.bSearch({ $0 >= 101 })).to(beNil())
                
                expect(self.intArray.bSearch({ $0 >= 0 })) == 1
                
                expect([].bSearch({ true })).to(beNil())
                
            }
            
            it("findAny") {
            
                1.upTo(10) { arraySize in
                
                    var testArray: [Int] = []
                    
                    1.upTo(arraySize) { i in
                        testArray += [i]
                    }
                    
                    for i in testArray {
                        expect(testArray.bSearch({ $0 - i })) == i
                    }
                    
                }
                
                expect(self.intArray.bSearch({ $0 - (self.intArray.max() + 1) })).to(beNil())
                expect(self.intArray.bSearch({ $0 - (self.intArray.min() - 1) })).to(beNil())
                
                expect([Int]().bSearch({ $0 })).to(beNil())
            
            }
            
        }
        
    }
    
}
