//
//  NSArrayExtensionsTests.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Quick
import Nimble

class NSArrayExtensionsSpec: QuickSpec {
    
    override func spec() {
    
        it("cast") {
            
            let array: NSArray = ["A", 10, "B", "C", false]
            
            expect(array.cast() as [NSNumber]) == [10, 0]
            expect(array.cast() as [NSString]) == ["A", "B", "C"]
            
            expect(array.cast() as [Int]) == [10, 0]
            
        }
        
        it("flatten") {
        
            let array = [5, [6, ["A", 7]], 8]
            
            expect(array.flatten() as [NSNumber]) == [5, 6, 7, 8]
            expect(array.flatten() as [Int]) == [5, 6, 7, 8]
            expect(array.flatten() as [String]) == ["A"]
            
            expect(array.flattenAny() as? [NSObject]) == [5, 6, "A", 7, 8]
            
        }
        
    }

}
