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
    subscript (range: Range<Int>) -> String? {
        if let chars = Array(unicodeScalars).get(range) {
        
            return chars.reduce(String(), combine: {
                (substring: String, char: UnicodeScalar) -> String in
                return substring + String(char)
            })

        }
        
        return nil
    }

    /**
    *  Returns the unicode char at position index in the string
    *  @return Unicode char as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
    
        if let char = Array(unicodeScalars).get(index) {
            return String(char)
        }
        
        return nil

    }
    
    /**
    *  String length in terms of unicode chars
    *  @return Length
    */
    func length () -> Int {

        return Array(unicodeScalars).count
        
    }
    
    /**
    *  Random string
    *  @param length String length, 0 -> random length
    *  @param charset Chars to use in the random string costruction
    *  @return Random string
    */
    static func random (var length len: Int = 0, charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {
        
        if len < 1 {
            len = Int.random(max: 16)
        }
        
        var result = String()
        let max = charset.length() - 1
        
        for i in 0..len {
            result += charset[Int.random(min: 0, max: max)]!
        }
        
        return result
        
    }
    
}

/**
*  Repeat a string
*/
@infix func * (first: String, second: Int) -> String {
    var result = String()

    second.times {
        result += first
    }
    
    return result
}
