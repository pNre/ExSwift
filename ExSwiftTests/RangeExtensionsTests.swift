//
//  RangeExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class RangeExtensionsSpec: QuickSpec {
    
    override func spec() {
    
        /**
        *  Range.times
        */
        it("times") {
        
            var count: Int = 0
            (2..<4).times { count++ }
            
            expect(count) == 2
            
            count = 0
            (2...4).times { count++ }
            
            expect(count) == 3
        
        }
        
        /**
        *  Range.each
        */
        it("each") {
        
            var items = [Int]()
            (0..<2).each(items.append)
        
            expect(items) == [0, 1]
            
            (0..<0).each { (current: Int) in
                fail()
            }

        }
    
    }

}

