//
//  SequenceExtensionsTests.swift
//  ExSwift
//
//  Created by Colin Eberhardt on 24/06/2014.
//  Copyright (c) 2014 pNre. All rights reserved.
//


import Quick
import Nimble

class SequenceExtensionsSpec: QuickSpec {
    
    var sequence = 1...5
    var emptySequence = 1..<1
    
    override func spec() {
    
        it("first") {
            
            expect(SequenceOf(self.sequence).first) == 1
            
            expect(SequenceOf(self.emptySequence).first).to(beNil())
            
        }
        
        it("contains") {
            
            expect(SequenceOf(self.sequence).contains(1)).to(beTrue())
            expect(SequenceOf(self.sequence).contains(56)).to(beFalse())
            
        }
        
        it("indexOf") {
            
            expect(SequenceOf(self.sequence).indexOf(2)) == 1
            expect(SequenceOf(self.sequence).indexOf(56)).to(beNil())
            
        }
        
        it("skip") {
            
            expect(Array(SequenceOf(self.sequence).skip(0))) == Array(SequenceOf(self.sequence))
            
            expect(Array(SequenceOf(self.sequence).skip(2))) == [3, 4, 5]
            
            expect(Array(SequenceOf(self.sequence).skip(8))) == []
            
        }
        
        it("skipWhile") {
            
            expect(Array(SequenceOf(self.sequence).skipWhile { $0 < 3 })) == [3, 4, 5]
            
            expect(Array(SequenceOf(self.sequence).skipWhile { $0 < 20 })) == []
            
        }
        
        it("take") {
            
            expect(Array(SequenceOf(self.sequence).take(0))) == []
            
            expect(Array(SequenceOf(self.sequence).take(2))) == [1, 2]
            
            expect(Array(SequenceOf(self.sequence).take(20))) == Array(SequenceOf(self.sequence))
            
        }
        
        it("takeWhile") {
            
            expect(Array(SequenceOf(self.sequence).takeWhile { $0 != 3 })) == [1, 2]
            
            expect(Array(SequenceOf(self.sequence).takeWhile { $0 == 7 })) == []
            
            expect(Array(SequenceOf(self.sequence).takeWhile { $0 != 7 })) == [1, 2, 3, 4, 5]
            
        }
        
        describe("get") {
            
            it("index") {
                
                expect(SequenceOf(self.sequence).get(3)) == 3
                expect(SequenceOf(self.sequence).get(22)).to(beNil())
                
            }
            
            it("range") {
            
                expect(Array(SequenceOf(self.sequence).get(1..<3))) == [2, 3]
                
                expect(Array(SequenceOf(self.sequence).get(0..<0))) == []
                
                expect(Array(SequenceOf(self.sequence).get(10..<15))) == []
                
            }
            
        }
        
        it("any") {
            
            expect(SequenceOf(self.sequence).any { $0 == 1 }).to(beTrue())
            
            expect(SequenceOf(self.sequence).any { $0 == 77 }).to(beFalse())
            
        }
        
        it("filter") {
            
            var evens = SequenceOf(self.sequence).filter { $0 % 2 == 0 }
            expect(Array(evens)) == [2, 4]
            
            var odds = SequenceOf(self.sequence).filter { $0 % 2 == 1 }
            expect(Array(odds)) == [1, 3, 5]
            
            var all = SequenceOf(self.sequence).filter { $0 < 10 }
            expect(Array(all)) == [1, 2, 3, 4, 5]
            
            var none = SequenceOf(self.sequence).filter { $0 > 10 }
            expect(Array(none)) == []
            
        }
        
        it("reject") {
            
            var rejected = SequenceOf(self.sequence).reject { $0 == 3 }
            expect(Array(rejected)) == [1, 2, 4, 5]
            
            rejected = SequenceOf(self.sequence).reject { $0 == 1 }
            expect(Array(rejected)) == [2, 3, 4, 5]
            
            rejected = SequenceOf(self.sequence).reject { $0 == 10 }
            expect(Array(rejected)) == [1, 2, 3, 4, 5]
            
        }
        
    }

}
