//
//  Character.swift
//  ExSwift
//
//  Created by Cenny Davidsson on 2014-12-08.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension Character {
    
    /**
        If the character represents an integer that fits into an Int, returns
        the corresponding integer.
    */
    public func toInt () -> Int? {
        return Int(String(self))
    }
    
}