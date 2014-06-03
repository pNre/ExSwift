//
//  String.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension String {
    
    subscript(index: Int) -> UnicodeScalar? {
    
        var current = 0
            
        for char in self.unicodeScalars {
            
            if (current == index) {
                return char
            }
            
            current++
            
        }
        
        return nil
            
    }
    
}