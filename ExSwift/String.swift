//
//  String.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension String {
    
    /**
    *  Returns the substring in the given range
    *  @return Substring
    */
    subscript (range: Range<Int>) -> String {
        var substring = String()
        var start = range.startIndex
        var stop = range.endIndex
            
        for char in unicodeScalars {
            if start <= 0 && stop > 0 {
                substring += String(char)
            }
            
            start--
            stop--
            
        }
            
        return substring
    }
    
    /**
    *  Returns the unicode char at position index in the string
    *  @return Unicode char as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
    
        var current = 0
            
        for char in unicodeScalars {
            
            if (current == index) {
                return String(char)
            }
            
            current++
            
        }
        
        return nil
            
    }
    
    /**
    *  String length in terms of unicode chars
    *  @return Length
    */
    func length () -> Int {
        
        var length = 0
        
        for char in unicodeScalars {
            length++
        }
        
        return length
        
    }
    
}

