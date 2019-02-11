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
            
            expect(AnySequence(self.sequence).first) == 1
            
            expect(AnySequence(self.emptySequence).first).to(beNil())
            
        }
        
        it("contains") {
            
            expect(AnySequence(self.sequence).contains(1)).to(beTrue())
            expect(AnySequence(self.sequence).contains(56)).to(beFalse())
            
        }
        
        it("indexOf") {
            
            expect(AnySequence(self.sequence).indexOf(2)) == 1
            expect(AnySequence(self.sequence).indexOf(56)).to(beNil())
            
        }
        
        it("skip") {
            
            expect(Array(AnySequence(self.sequence).skip(0))) == Array(AnySequence(self.sequence))
            
            expect(Array(AnySequence(self.sequence).skip(2))) == [3, 4, 5]
            
            expect(Array(AnySequence(self.sequence).skip(8))) == []
            
        }
        
        it("skipWhile") {
            
            expect(Array(AnySequence(self.sequence).skipWhile { $0 < 3 })) == [3, 4, 5]
            
            expect(Array(AnySequence(self.sequence).skipWhile { $0 < 20 })) == []
            
        }
        
        it("take") {
            
            expect(Array(AnySequence(self.sequence).take(0))) == []
            
            expect(Array(AnySequence(self.sequence).take(2))) == [1, 2]
            
            expect(Array(AnySequence(self.sequence).take(20))) == Array(AnySequence(self.sequence))
            
        }
        
        it("takeWhile") {
            
            expect(Array(AnySequence(self.sequence).takeWhile { $0 != 3 })) == [1, 2]
            
            expect(Array(AnySequence(self.sequence).takeWhile { $0 == 7 })) == []
            
            expect(Array(AnySequence(self.sequence).takeWhile { $0 != 7 })) == [1, 2, 3, 4, 5]
            
        }
        
        describe("get") {
            
            it("index") {
                
                expect(AnySequence(self.sequence).get(3)) == 3
                expect(AnySequence(self.sequence).get(22)).to(beNil())
                
            }
            
            it("range") {
            
                expect(Array(AnySequence(self.sequence).get(1..<3))) == [2, 3]
                
                expect(Array(AnySequence(self.sequence).get(0..<0))) == []
                
                expect(Array(AnySequence(self.sequence).get(10..<15))) == []
                
            }
            
        }
        
        it("any") {
            
            expect(AnySequence(self.sequence).any { $0 == 1 }).to(beTrue())
            
            expect(AnySequence(self.sequence).any { $0 == 77 }).to(beFalse())
            
        }
        
        it("filter") {
            
            let evens = AnySequence(self.sequence).filter { $0 % 2 == 0 }
            expect(Array(evens)) == [2, 4]
            
            let odds = AnySequence(self.sequence).filter { $0 % 2 == 1 }
            expect(Array(odds)) == [1, 3, 5]
            
            let all = AnySequence(self.sequence).filter { $0 < 10 }
            expect(Array(all)) == [1, 2, 3, 4, 5]
            
            let none = AnySequence(self.sequence).filter { $0 > 10 }
            expect(Array(none)) == []
            
        }
        
        it("reject") {
            
            var rejected = AnySequence(self.sequence).reject { $0 == 3 }
            expect(Array(rejected)) == [1, 2, 4, 5]
            
            rejected = AnySequence(self.sequence).reject { $0 == 1 }
            expect(Array(rejected)) == [2, 3, 4, 5]
            
            rejected = AnySequence(self.sequence).reject { $0 == 10 }
            expect(Array(rejected)) == [1, 2, 3, 4, 5]
            
        }
        
    }

}
