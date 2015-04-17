//
//  DictionaryExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class DictionaryExtensionsSpec: QuickSpec {
    
    var dictionary: [String: Int] = [String: Int]()
    
    override func spec() {
        
        beforeEach { () -> () in
            
            self.dictionary = [
                "A": 1,
                "B": 2,
                "C": 3
            ]
            
        }
        
        /**
        *  Dictionary.has
        */
        it("has") {
            
            expect(self.dictionary.has("A")).to(beTrue())
            expect(self.dictionary.has("Z")).to(beFalse())
            
        }
        
        /**
        *  Dictionary.mapValues
        */
        it("mapValues") {
            
            let mapped = self.dictionary.mapValues({ key, value -> Int in
                return value + 1
            })
            
            expect(mapped) == ["A": 2, "B": 3, "C": 4]
            
        }
        
        /**
        *  Dictionary.map
        */
        it("map") {
            
            let mapped = self.dictionary.map({ key, value -> (String, Int) in return (key + "A", value + 1) })
        
            expect(mapped) == ["AA": 2, "BA": 3, "CA": 4]
        
        }
        
        /**
        *  Dictionary.mapFilterValues
        */
        it("mapFilterValues") {
            
            let result = self.dictionary.mapFilterValues { (key, value) -> Int? in
                if key == "B" {
                    return nil
                }
                
                return value + 1
            }
            
            expect(result) == ["A": 2, "C": 4]
            
            expect(self.dictionary.mapFilterValues { (key, value) -> Int? in nil }) == [String: Int]()
            expect(self.dictionary.mapFilterValues { (key, value) -> Int? in value }) == self.dictionary
            
        }
        
        /**
        *  Dictionary.mapFilter
        */
        it("mapFilter") {
            
            let mapped = self.dictionary.mapFilter({ key, value -> (String, String)? in
                if key == "C" {
                    return ("D", key)
                }
                
                return nil
            })
            
            expect(mapped) == ["D": "C"]
            
            expect(self.dictionary.mapFilter { (key, value) -> (String, String)? in nil }) == [String: String]()
            expect(self.dictionary.mapFilter { (key, value) -> (String, Int)? in (key, value) }) == self.dictionary
            
        }
        
        /**
        *  Dictionary.filter
        */
        it("filter") {

            expect(self.dictionary.filter { key, _ in return key != "A" }) == ["B": 2, "C": 3]
            
            expect(self.dictionary.filter { key, _ in return false }) == [String: Int]()
            expect(self.dictionary.filter { key, _ in return true }) == self.dictionary
            
        }
        
        /**
        *  Dictionary.countWhere
        */
        it("countWhere") {
            
            expect(self.dictionary.countWhere { key, _ in return key != "A" }) == 2
            
            expect(self.dictionary.countWhere { key, _ in return false }) == 0
            expect(self.dictionary.countWhere { key, _ in return true }) == 3
            
        }
        
        /**
        *  Dictionary.any
        */
        it("any") {
            
            expect(self.dictionary.any { _, value -> Bool in return value % 2 == 0 }).to(beTrue())
            
            expect(self.dictionary.any { _, value -> Bool in return value >= 0 }).to(beTrue())
            
            expect(self.dictionary.any { _, value -> Bool in return value < 0 }).to(beFalse())
            
        }
        
        /**
        *  Dictionary.all
        */
        it("all") {
            
            expect(self.dictionary.all { _, value -> Bool in return value % 2 == 0 }).to(beFalse())
            
            expect(self.dictionary.all { _, value -> Bool in return value >= 0 }).to(beTrue())
            
            expect(self.dictionary.all { _, value -> Bool in return value < 0 }).to(beFalse())
            
        }
        
        /**
        *  Dictionary.shift
        */
        it("shift") {
            
            let unshifted = self.dictionary
            let (key, value) = self.dictionary.shift()!
            
            expect(unshifted.keys.array).to(contain(key))
            expect(self.dictionary.keys.array).toNot(contain(key))
            
            expect(unshifted[key]) == value
            expect(self.dictionary[key]).to(beNil())
            
            expect(unshifted.values.array).to(contain(value))
            expect(self.dictionary.values.array).toNot(contain(value))
            
        }
        
        /**
        *  Dictionary.pick
        */
        it("pick") {

            let pick1 = self.dictionary.pick(["A", "C"])
            
            expect(pick1) == ["A": 1, "C": 3]
            
            let pick2 = self.dictionary.pick("A", "C")
            
            expect(pick2) == pick1
            
            expect(self.dictionary.pick(["K"])) == [:]
            expect(self.dictionary.pick([])) == [:]
            expect(self.dictionary.pick()) == [:]
            
        }
        
        /**
        *  Dictionary.groupBy
        */
        it("groupBy") {
        
            let grouped = self.dictionary.groupBy { _, value -> Bool in
                return (value % 2 == 0)
            }
            
            expect(grouped.keys.array - [false, true]).to(beEmpty())
            expect(grouped[true]) == [2]
            
            expect(grouped[false]!.count) == 2
            expect(grouped[false]! - [1, 3]).to(beEmpty())
            
        }
        
        /**
        *  Dictionary.countBy
        */
        it("countBy") {
            
            let grouped = self.dictionary.countBy { _, value -> Bool in
                return (value % 2 == 0)
            }
            
            expect(grouped.keys.array - [false, true]).to(beEmpty())
            expect(grouped[true]) == 1
            expect(grouped[false]) == 2
            
        }
        
        /**
        *  Dictionary.reduce
        */
        it("reduce") {
        
            let reduced1 = self.dictionary.reduce([Int: String](), combine: {
                (var initial: [Int: String], couple: (String, Int)) in
                initial.updateValue(couple.0, forKey: couple.1)
                return initial
            })
        
            expect(reduced1) == [2: "B", 3: "C", 1: "A"]
        
            let reduced2 = self.dictionary.reduce(0, combine: { (initial: Int, couple: (String, Int)) in
                return initial + couple.1
            })
        
            expect(reduced2) == self.dictionary.values.array.reduce(+)
        
        }
        
        /**
        *  Dictionary.difference
        */
        describe("difference") {
        
            let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
            let dictionary2 = [ "A": 1 ]
            let dictionary3 = [ "B": 2, "C": 3 ]
        
            it("operator") {
                
                expect(self.dictionary - dictionary1) == [:]
                expect(self.dictionary - dictionary2) == [ "B": 2, "C": 3 ]
                expect(self.dictionary - dictionary3) == [ "A": 1 ]
                
                expect(dictionary2 - dictionary3) != (dictionary3 - dictionary2)
                
                expect(dictionary2 - dictionary3) == dictionary2
                expect(dictionary2 - [:]) == dictionary2
                
            }
            
            it("method") {
                
                expect(self.dictionary.difference(dictionary1)) == [:]
                expect(self.dictionary.difference(dictionary2)) == [ "B": 2, "C": 3 ]
                expect(self.dictionary.difference(dictionary3)) == [ "A": 1 ]
                
                expect(dictionary2.difference(dictionary3)) != dictionary3.difference(dictionary2)
                
                expect(dictionary2.difference(dictionary3)) == dictionary2
                expect(dictionary2.difference([:])) == dictionary2
                
            }
            
        }
        
        /**
        *  Dictionary.union
        */
        describe("union") {
            
            let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
            let dictionary2 = [ "A": 1 ]
            let dictionary3 = [ "B": 2, "C": 3 ]
            
            it("operator") {
                
                expect(self.dictionary | dictionary1) == self.dictionary
                expect(self.dictionary | dictionary2) == self.dictionary
                expect(self.dictionary | dictionary3) == self.dictionary
                
                expect(dictionary2 | dictionary3) == (dictionary3 | dictionary2)
                expect(dictionary2 | dictionary3) == self.dictionary
    
                expect(dictionary1 | [:]) == dictionary1
                
            }
            
            it("method") {
                
                expect(self.dictionary.union(dictionary1)) == self.dictionary
                expect(self.dictionary.union(dictionary2)) == self.dictionary
                expect(self.dictionary.union(dictionary3)) == self.dictionary
                
                expect(dictionary2.union(dictionary3)) == dictionary3.union(dictionary2)
                expect(dictionary2.union(dictionary3)) == self.dictionary
                
                expect(dictionary1.union([:])) == dictionary1
                
            }
            
        }
        
        /**
        *  Dictionary.intersection
        */
        describe("intersection") {
            
            let dictionary1 = [ "A": 1, "B": 2, "C": 3 ]
            let dictionary2 = [ "A": 1 ]
            let dictionary3 = [ "B": 2, "C": 3 ]
            
            it("operator") {
                
                expect(self.dictionary & dictionary1) == self.dictionary
                expect(self.dictionary & dictionary2) == dictionary2
                expect(self.dictionary & dictionary3) == dictionary3
                
                expect(dictionary2 & dictionary3) == (dictionary3 & dictionary2)
                expect(dictionary2 & dictionary3) == [String: Int]()
                
                expect(dictionary1 & [:]) == [:]
                
            }
            
            it("method") {
                
                expect(self.dictionary.intersection(dictionary1)) == self.dictionary
                expect(self.dictionary.intersection(dictionary2)) == dictionary2
                expect(self.dictionary.intersection(dictionary3)) == dictionary3
                
                expect(dictionary2.intersection(dictionary3)) == dictionary3.intersection(dictionary2)
                expect(dictionary2.intersection(dictionary3)) == [String: Int]()
                
                expect(dictionary1.intersection([:])) == [String: Int]()
                
            }
            
        }
        
        /**
        *  Dictionary.toArray
        */
        it("toArray") {
            
            expect(self.dictionary.toArray({ (key, value) -> String in key })) == self.dictionary.keys.array
            expect(self.dictionary.toArray({ (key, value) -> Int in value })) == self.dictionary.values.array
            
            expect(self.dictionary.toArray({ (key, value) -> Bool in false })) == [false, false, false]
            
        }
        
    }
    
}
