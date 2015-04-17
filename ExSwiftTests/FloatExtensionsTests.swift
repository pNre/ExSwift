//
//  FloatExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class FloatExtensionsSpec: QuickSpec {
    
    override func spec() {
        
        /**
        *  Float.abs
        */
        it("abs") {
            
            expect(Float(0).abs()) == Float(0)
            
            expect(Float(-1).abs()).to(beCloseTo(1, within: 0.001))
            expect(Float(1).abs()).to(beCloseTo(1, within: 0.001))
            
            expect(Float(-111.2).abs()).to(beCloseTo(111.2, within: 0.001))
            expect(Float(111.2).abs()).to(beCloseTo(111.2, within: 0.001))
            
        }
        
        /**
        *  Float.sqrt
        */
        it("sqrt") {
            
            expect(Float(0).sqrt()) == Float(0)
            
            expect(Float(4).sqrt()).to(beCloseTo(2, within: 0.001))
            expect(Float(111.2).sqrt()).to(beCloseTo(sqrt(111.2), within: 0.001))
            
            expect(isnan(Float(-10).sqrt())).to(beTrue())
            
        }
        
        /**
        *  Float.floor
        */
        it("floor") {
            
            expect(Float(0).floor()) == Float(0)
            
            expect(Float(4.99999).floor()).to(beCloseTo(4, within: 0.001))
            expect(Float(4.001).floor()).to(beCloseTo(4, within: 0.001))
            expect(Float(4.5).floor()).to(beCloseTo(4, within: 0.001))
            
            expect(Float(-4.99999).floor()).to(beCloseTo(-5, within: 0.001))
            expect(Float(-4.001).floor()).to(beCloseTo(-5, within: 0.001))
            expect(Float(-4.5).floor()).to(beCloseTo(-5, within: 0.001))
            
        }
        
        /**
        *  Float.ceil
        */
        it("ceil") {
            
            expect(Float(0).ceil()) == Float(0)
            
            expect(Float(4.99999).ceil()).to(beCloseTo(5, within: 0.001))
            expect(Float(4.001).ceil()).to(beCloseTo(5, within: 0.001))
            expect(Float(4.5).ceil()).to(beCloseTo(5, within: 0.001))
            
            expect(Float(-4.99999).ceil()).to(beCloseTo(-4, within: 0.001))
            expect(Float(-4.001).ceil()).to(beCloseTo(-4, within: 0.001))
            expect(Float(-4.5).ceil()).to(beCloseTo(-4, within: 0.001))
            
        }
        
        /**
        *  Float.round
        */
        it("round") {
            
            expect(Float(0).round()) == Float(0)
            
            expect(Float(4.99999999).round()).to(beCloseTo(5, within: 0.001))
            expect(Float(4.001).round()).to(beCloseTo(4, within: 0.001))
            expect(Float(4.5).round()).to(beCloseTo(5, within: 0.001))
            
            expect(Float(4.3).round()).to(beCloseTo(4, within: 0.001))
            expect(Float(4.7).round()).to(beCloseTo(5, within: 0.001))
            
            expect(Float(-4.99999999).round()).to(beCloseTo(-5, within: 0.001))
            expect(Float(-4.001).round()).to(beCloseTo(-4, within: 0.001))
            expect(Float(-4.5).round()).to(beCloseTo(-5, within: 0.001))
            
        }
        
        /**
        *  Float.roundToNearest
        */
        it("roundToNearest") {
            
            expect(2.5.roundToNearest(0.3)).to(beCloseTo(2.4, within: 0.01))
            expect(0.roundToNearest(0.3)).to(beCloseTo(0.0, within: 0.01))
            expect(4.0.roundToNearest(2)).to(beCloseTo(4.0, within: 0.01))
            expect(10.0.roundToNearest(3)).to(beCloseTo(9.0, within: 0.01))
            expect(-2.0.roundToNearest(3)).to(beCloseTo(-3.0, within: 0.01))
            
        }
        
        /**
        *  Float.clamp
        */
        it("clamp") {
            
            expect(Float(0.25).clamp(0, 0.5)).to(beCloseTo(0.25, within: 0.01))
            expect(Float(2).clamp(0, 0.5)).to(beCloseTo(0.5, within: 0.01))
            expect(Float(-2).clamp(0, 0.5)).to(beCloseTo(0, within: 0.01))
            
        }
        
    }
    
}
