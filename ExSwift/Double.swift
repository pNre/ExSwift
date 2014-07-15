//
//  Double.swift
//  ExSwift
//
//  Created by pNre on 10/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Double {
    
    /**
    *  Absolute value
    *  @return fabs(self)
    */
    func abs () -> Double {
        return Foundation.fabs(self)
    }
    
    /**
    *  Squared root
    *  @return sqrt(self)
    */
    func sqrt () -> Double {
        return Foundation.sqrt(self)
    }
    
    /**
    *  Rounds self to the largest integer <= self
    *  @return floor(self)
    */
    func floor () -> Double {
        return Foundation.floor(self)
    }
    
    /**
    *  Rounds self to the smallest integer >= self
    *  @return ceil(self)
    */
    func ceil () -> Double {
        return Foundation.ceil(self)
    }
    
    /**
    *  Rounds self to the nearest integer
    *  @return round(self)
    */
    func round () -> Double {
        return Foundation.round(self)
    }
    
    /**
    *  Random double between min and max (inclusive)
    *  @param min
    *  @param max
    *  @return Random number
    */
    static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min;
        let rand = Double(arc4random() % (RAND_MAX.asUnsigned() + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min;
    }
    
}
