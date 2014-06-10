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
    *  Returns the absolute value of self
    */
    func abs () -> Float {
        return fabsf(self)
    }
    
    /**
    *  Returns the squared root of self
    */
    func sqrt () -> Float {
        return sqrtf(self)
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

