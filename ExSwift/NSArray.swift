//
//  NSArray.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension NSArray {

    /**
    *  Converts an NSArray object to an OutType[] array containing 
    *  the items in the NSArray that can be bridged from their ObjC type to OutType.
    *  @return Swift Array
    */
    func cast <OutType> () -> Array<OutType> {
        var result = Array<OutType>()
        
        for item : AnyObject in self {
            //  Keep only objC objects compatible with OutType
            if var converted = bridgeFromObjectiveCConditional(item, OutType.self) {
                result.append(converted)
            }
        }
        
        return result
    }
    
    /**
    *  Flattens a multidimensional NSArray to an OutType[] array containing
    *  the items in the NSArray that can be bridged from their ObjC type to OutType.
    *  @return Flattened array
    */
    func flatten <OutType> () -> Array<OutType> {

        var result = Array<OutType>()
        
        for item: AnyObject in self {
            if let converted = bridgeFromObjectiveCConditional(item, OutType.self) {
                result.append(converted)
            } else if item is NSArray {
                result += (item as NSArray).flatten() as Array<OutType>
            }
        }
        
        return result
        
    }

}
