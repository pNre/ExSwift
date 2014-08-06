//
//  Double.swift
//  ExSwift
//
//  Created by pNre on 10/07/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Double {
    
    /**
        Absolute value.
    
        :returns: fabs(self)
    */
    func abs () -> Double {
        return Foundation.fabs(self)
    }
    
    /**
        Squared root.
    
        :returns: sqrt(self)
    */
    func sqrt () -> Double {
        return Foundation.sqrt(self)
    }
    
    /**
        Rounds self to the largest integer <= self.
    
        :returns: floor(self)
    */
    func floor () -> Double {
        return Foundation.floor(self)
    }
    
    /**
        Rounds self to the smallest integer >= self.
    
        :returns: ceil(self)
    */
    func ceil () -> Double {
        return Foundation.ceil(self)
    }
    
    /**
        Rounds self to the nearest integer.
    
        :returns: round(self)
    */
    func round () -> Double {
        return Foundation.round(self)
    }
    
    /**
        Random double between min and max (inclusive).
    
        :params: min
        :params: max
        :returns: Random number
    */
    static func random(min: Double = 0, max: Double) -> Double {
        let diff = max - min;
        let rand = Double(arc4random() % (UInt32(RAND_MAX) + 1))
        return ((rand / Double(RAND_MAX)) * diff) + min;
    }
    
}
