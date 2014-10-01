//
//  NSArray.swift
//  ExSwift
//
//  Created by pNre on 10/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension NSArray {

    /**
        Converts an NSArray object to an OutType[] array containing the items in the NSArray of type OutType.
        
        :returns: Array of Swift objects
    */
    func cast <OutType> () -> [OutType] {
        var result = [OutType]()
        
        for item : AnyObject in self {
            result += Ex.bridgeObjCObject(item) as [OutType]
        }
        
        return result
    }

    /**
        Flattens a multidimensional NSArray to an OutType[] array 
        containing the items in the NSArray that can be bridged from their ObjC type to OutType.
    
        :returns: Flattened array
    */
    func flatten <OutType> () -> [OutType] {
        var result = [OutType]()
        let reflection = reflect(self)
        
        for i in 0..<reflection.count {
            result += Ex.bridgeObjCObject(reflection[i].1.value) as [OutType]
        }
        
        return result
    }
    
    /**
        Flattens a multidimensional NSArray to a [AnyObject].
    
        :returns: Flattened array
    */
    func flattenAny () -> [AnyObject] {
        var result = [AnyObject]()
        
        for item in self {
            if let array = item as? NSArray {
                result += array.flattenAny()
            } else {
                result.append(item)
            }
        }
        
        return result
    }
    
}
