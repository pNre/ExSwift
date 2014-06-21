//
//  Float.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Float {

    func abs () -> Float {
        return fabsf(self)
    }

    func sqrt () -> Float {
        return sqrtf(self)
    }
    
    func floor () -> Float {
        return floorf(self)
    }
    
    func ceil () -> Float {
        return ceilf(self)
    }

    func round () -> Float {
        return roundf(self)
    }
    
    /**
    * Returns couple of Integer arrays: integer and fractional part of `self`
    */
    func digits () -> (integerPart: Int[], fractionalPart: Int[]) {
        var first: Int[]? = nil
        var current = Int[]()
        
        for char in String(self) {
            let string = String(char)
            if let toInt = string.toInt() {
                current.append(toInt)
            } else if string == "." {
                first = current
                current.removeAll(keepCapacity: true)
            }
        }
        
        if let integer = first {
            return (integer, current)
        }
        
        return (current, [0])
    }
    
    /**
    *  Returns a random float between min and max (inclusive)
    *  @return Random float
    */
    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min;
        let rand = Float(arc4random() % (RAND_MAX.asUnsigned() + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min;
    }
    
}

