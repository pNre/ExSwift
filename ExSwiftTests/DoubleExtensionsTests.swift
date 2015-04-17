//
//  DoubleExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 10/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class DoubleExtensionsSpec: QuickSpec {

    override func spec() {
    
        /**
        *  Double.abs
        */
        it("abs") {
            
            expect(Double(0).abs()) == Double(0)
            
            expect(Double(-1).abs()).to(beCloseTo(1, within: 0.001))
            expect(Double(1).abs()).to(beCloseTo(1, within: 0.001))
            
            expect(Double(-111.2).abs()).to(beCloseTo(111.2, within: 0.001))
            expect(Double(111.2).abs()).to(beCloseTo(111.2, within: 0.001))
            
        }
        
        /**
        *  Double.sqrt
        */
        it("sqrt") {
            
            expect(Double(0).sqrt()) == Double(0)
            
            expect(Double(4).sqrt()).to(beCloseTo(2, within: 0.001))
            expect(Double(111.2).sqrt()).to(beCloseTo(sqrt(111.2), within: 0.001))
            
            expect(isnan(Double(-10).sqrt())).to(beTrue())
            
        }
        
        /**
        *  Double.floor
        */
        it("floor") {
            
            expect(Double(0).floor()) == Double(0)
            
            expect(Double(4.99999999).floor()).to(beCloseTo(4, within: 0.001))
            expect(Double(4.001).floor()).to(beCloseTo(4, within: 0.001))
            expect(Double(4.5).floor()).to(beCloseTo(4, within: 0.001))
            
            expect(Double(-4.99999999).floor()).to(beCloseTo(-5, within: 0.001))
            expect(Double(-4.001).floor()).to(beCloseTo(-5, within: 0.001))
            expect(Double(-4.5).floor()).to(beCloseTo(-5, within: 0.001))
            
        }
        
        /**
        *  Double.ceil
        */
        it("ceil") {
            
            expect(Double(0).ceil()) == Double(0)
            
            expect(Double(4.99999999).ceil()).to(beCloseTo(5, within: 0.001))
            expect(Double(4.001).ceil()).to(beCloseTo(5, within: 0.001))
            expect(Double(4.5).ceil()).to(beCloseTo(5, within: 0.001))
            
            expect(Double(-4.99999999).ceil()).to(beCloseTo(-4, within: 0.001))
            expect(Double(-4.001).ceil()).to(beCloseTo(-4, within: 0.001))
            expect(Double(-4.5).ceil()).to(beCloseTo(-4, within: 0.001))
            
        }
        
        /**
        *  Double.round
        */
        it("round") {
        
            expect(Double(0).round()) == Double(0)
            
            expect(Double(4.99999999).round()).to(beCloseTo(5, within: 0.001))
            expect(Double(4.001).round()).to(beCloseTo(4, within: 0.001))
            expect(Double(4.5).round()).to(beCloseTo(5, within: 0.001))
            
            expect(Double(4.3).round()).to(beCloseTo(4, within: 0.001))
            expect(Double(4.7).round()).to(beCloseTo(5, within: 0.001))
            
            expect(Double(-4.99999999).round()).to(beCloseTo(-5, within: 0.001))
            expect(Double(-4.001).round()).to(beCloseTo(-4, within: 0.001))
            expect(Double(-4.5).round()).to(beCloseTo(-5, within: 0.001))
            
        }
        
        /**
        *  Double.roundToNearest
        */
        it("roundToNearest") {
        
            expect(2.5.roundToNearest(0.3)).to(beCloseTo(2.4, within: 0.01))
            expect(0.roundToNearest(0.3)).to(beCloseTo(0.0, within: 0.01))
            expect(4.0.roundToNearest(2)).to(beCloseTo(4.0, within: 0.01))
            expect(10.0.roundToNearest(3)).to(beCloseTo(9.0, within: 0.01))
            expect(-2.0.roundToNearest(3)).to(beCloseTo(-3.0, within: 0.01))
            
        }
        
        /**
        *  Double.clamp
        */
        it("clamp") {
            
            expect(Double(0.25).clamp(0, 0.5)).to(beCloseTo(0.25, within: 0.01))
            expect(Double(2).clamp(0, 0.5)).to(beCloseTo(0.5, within: 0.01))
            expect(Double(-2).clamp(0, 0.5)).to(beCloseTo(0, within: 0.01))

        }
        
    }
    
}
