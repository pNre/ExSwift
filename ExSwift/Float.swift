//
//  Float.swift
//  ExSwift
//
//  Created by pNre on 04/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Float {

    /**
    *  Absolute value
    *  @return fabs(self)
    */
    func abs () -> Float {
        return fabsf(self)
    }

    /**
    *  Squared root
    *  @return sqrtf(self)
    */
    func sqrt () -> Float {
        return sqrtf(self)
    }
    
    /**
    *  Rounds self to the largest integer <= self
    *  @return floorf(self)
    */
    func floor () -> Float {
        return floorf(self)
    }
    
    /**
    *  Rounds self to the smallest integer >= self
    *  @return ceilf(self)
    */
    func ceil () -> Float {
        return ceilf(self)
    }
    
    /**
    *  Rounds self to the nearest integer
    *  @return roundf(self)
    */
    func round () -> Float {
        return roundf(self)
    }
    
    /**
    *  Returns a couple of Int[] arrays containing the digits of
    *  the integer and the fractional part of self.
    *  @return (integer, fractional)
    */
    func digits () -> (integerPart: Array<Int>, fractionalPart: Array<Int>) {
        var first: Array<Int>? = nil
        var current = Array<Int>()
        
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
    *  Random float between min and max (inclusive)
    *  @param min
    *  @param max
    *  @return Random number
    */
    static func random(min: Float = 0, max: Float) -> Float {
        let diff = max - min;
        let rand = Float(arc4random() % (RAND_MAX.asUnsigned() + 1))
        return ((rand / Float(RAND_MAX)) * diff) + min;
    }
    
}

