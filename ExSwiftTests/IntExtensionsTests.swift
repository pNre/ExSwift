//
//  IntExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class IntExtensionsSpec: QuickSpec {
    
    override func spec() {
        
        /**
        *  Int.times
        */
        describe("times") {
            
            it("iteration") {
            
                var count = 0
                
                5.times { count++ }
                expect(count).to(equal(5))
                
                0.times { count++ }
                expect(count).to(equal(5))
                
            }
            
            it("index") {
            
                var indexes = [Int]()
                5.times(indexes.append)
                
                expect(indexes) == [0, 1, 2, 3, 4]
                
            }

        }
        
        /**
        *  Int.even
        */
        it("even") {
        
            expect((-1).isEven()).to(beFalse())
            expect(3.isEven()).to(beFalse())
            
            expect((-2).isEven()).to(beTrue())
            expect(4.isEven()).to(beTrue())
            
        }
        
        /**
        *  Int.odd
        */
        it("odd") {
            
            expect((-1).isOdd()).to(beTrue())
            expect(3.isOdd()).to(beTrue())
            
            expect((-2).isOdd()).to(beFalse())
            expect(4.isOdd()).to(beFalse())
            
        }
        
        /**
        *  Int.random
        */
        it("random") {
        
            var indexes = [Int]()
            10.times { indexes.append(Int.random(min: 5, max: 25)) }
            
            expect(indexes).to(allPass { $0 >= 5 && $0 <= 25 })
        
        }
        
        /**
        *  Int.upTo
        */
        it("upTo") {
            
            var result = [Int]()
            5.upTo(10, function: result.append)
            
            expect(result) == [Int](5...10)
            
        }
        
        /**
        *  Int.downTo
        */
        it("downTo") {
            
            var result = [Int]()
            5.downTo(0, function: result.append)
            
            expect(result) == [5, 4, 3, 2, 1, 0]
            
        }
        
        /**
        *  Int.clamp
        */
        it("clamp") {
            
            expect(5.clamp(0...4)) == 4
            expect(3.clamp(0...4)) == 3
            expect(1.clamp(2...4)) == 2
            
        }
        
        /**
        *  Int.isIn
        */
        it("isIn") {
        
            expect(2.isIn(0..<3)).to(beTrue())
            expect(2.isIn(0..<3, strict: true)).to(beFalse())
            
            expect(0.isIn(0..<3)).to(beTrue())
            expect(0.isIn(0..<3, strict: true)).to(beFalse())
            
            expect(2.isIn(0...2)).to(beTrue())
            expect(2.isIn(0...2, strict: true)).to(beFalse())
            
        }
        
        /**
        *  Int.explode
        */
        it("explode") {
            
            expect(0.digits()) == [0]
            
            expect(1234.digits()) == [1, 2, 3, 4]
            
        }
        
        /**
        *  Int.gcd
        */
        it("gcd") {
        
            expect(3.gcd(6)) == 3
            
            expect(6.gcd(3)) == 3
            
            expect(6124.gcd(342)) == 2
            
            expect(342.gcd(6124)) == 2
            
        }
        
        /**
        *  Int.lcm
        */
        it("lcm") {
            
            expect(3.lcm(4)) == 12
            
            expect(4.lcm(3)) == 12

        }
        
        /**
        *  Int.abs
        */
        it("abs") {
            
            expect((-1).abs()) == 1
            expect((-10).abs()) == 10
            
            expect(1.abs()) == 1
            
            expect(0.abs()) == 0
            
        }
        
        describe("time") {
            
            it("years") {
                
                expect(0.years) == 0
                expect(1.year) == 31536000
                expect(111.years) == 31536000 * 111
                
                expect(-1.year) == -31536000
                expect(-111.years) == -31536000 * 111
                
                expect(0.year) == 0.years
                expect(1.year) == 1.years
                expect(1010.year) == 1010.years
                
            }
            
            it("days") {
            
                expect(0.days) == 0
                expect(1.day) == 86400
                expect(111.days) == 86400 * 111
                
                expect(-1.day) == -86400
                expect(-111.days) == -86400 * 111
                
                expect(0.day) == 0.days
                expect(1.day) == 1.days
                expect(1010.day) == 1010.days
                
            }
            
            it("hours") {
                
                expect(0.hours) == 0
                expect(1.hour) == 3600
                expect(111.hours) == 3600 * 111
                
                expect(-1.hour) == -3600
                expect(-111.hours) == -3600 * 111
                
                expect(0.hour) == 0.hours
                expect(1.hour) == 1.hours
                expect(1010.hour) == 1010.hours
                
            }
            
            it("minutes") {
                
                expect(0.minutes) == 0
                expect(1.minute) == 60
                expect(111.minutes) == 60 * 111
                
                expect(-1.minute) == -60
                expect(-111.minutes) == -60 * 111

                expect(0.minute) == 0.minutes
                expect(1.minute) == 1.minutes
                expect(1010.minute) == 1010.minutes
                
            }
            
            it("seconds") {
                
                expect(0.seconds) == 0
                expect(1.second) == 1
                expect(111.seconds) == 111
                
                expect(-1.second) == -1
                expect(-111.seconds) == -111
                
                expect(0.second) == 0.seconds
                expect(1.second) == 1.seconds
                expect(1010.second) == 1010.seconds
                
            }
            
        }
        
    }

}
