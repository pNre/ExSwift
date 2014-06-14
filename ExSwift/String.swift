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
    *  String length
    */
    var length: Int {
        return countElements(self)
    }

    /**
    *  Returns the substring in the given range
    *  @return Substring
    */
    subscript (range: Range<Int>) -> String? {
        return Array(self).get(range).reduce(String(), +)
    }

    /**
    *  Same as `at`
    */
    subscript (indexes: Int...) -> String[] {
        return at(reinterpretCast(indexes))
    }

    /**
    *  Returns the unicode char at position index in the string
    *  @return Unicode char as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
        if let char = Array(self).get(index) {
            return String(char)
        }

        return nil
    }
    
    /**
    *  Creates an array of chars from the specified indexes of self
    */
    func at (indexes: Int...) -> String[] {
        return indexes.map { self[$0]! }
    }

    /**
    *  Returns an array of strings, each of which is a substring of self formed by splitting it on separator
    *  @param separator
    *  @return Array of strings
    */
    func explode (separator: Character) -> String[] {
        return split(self, {
            (element: Character) -> Bool in
            return element == separator
        })
    }

    /**
     *  Finds any match in self for pattern
     *  @param pattern Pattern to match
     *  @param ignoreCase True for case insensitive matching
     *  @return Matches
    */
    func matches (pattern: String, ignoreCase: Bool = false) -> NSTextCheckingResult[]? {

        if let regex = ExSwift.regex(pattern, ignoreCase: ignoreCase) {
            return regex.matchesInString(self, options: nil, range: NSMakeRange(0, length)) as? NSTextCheckingResult[]
        }
        
        return nil
    }
    
    /**
    *  `self` with capitalized first character
    */
    func capitalized () -> String {
        return capitalizedString
    }
    
    /**
    *  Inserts `string` before the character at the given `index`
    */
    func insert (index: Int, _ string: String) -> String {
        return self[0..index]! + string + self[index..length]!
    }

    /**
     * Strip whitespace from the beginning of a string.
     */
    func ltrimmed () -> String {
        let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet)
        return self[range.startIndex..endIndex]
    }
    
    /**
    * Strip whitespace from the end of a string.
    */
    func rtrimmed () -> String {
        let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet, options: NSStringCompareOptions.BackwardsSearch)
        return self[startIndex..range.endIndex]
    }
    
    /**
    * Strip whitespace from the beginning and end of a string.
    */
    func trimmed () -> String {
        return ltrimmed().rtrimmed()
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
        let max = charset.length - 1
        
        len.times {
            result += charset[Int.random(min: 0, max: max)]!
        }

        return result

    }
    
}

/**
*  Repeat a string
*/
@infix func * (first: String, n: Int) -> String {
    var result = String()

    n.times {
        result += first
    }
    
    return result
}

/**
 *  Pattern matching with a regex
 */
@infix func =~ (string: String, pattern: String) -> Bool {
    return string =~ (pattern: pattern, ignoreCase: false)
}

//  This version also allowes to specify case sentitivity
@infix func =~ (string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool {
    if let matches = ExSwift.regex(options.pattern, ignoreCase: options.ignoreCase)?.numberOfMatchesInString(string, options: nil, range: NSMakeRange(0, string.length)) {
        return matches > 0
    }
    
    return false
}

//  Match against all the alements in an array of String
@infix func =~ (strings: String[], pattern: String) -> Bool {
    return strings.all { $0 =~ (pattern: pattern, ignoreCase: false) }
}

@infix func =~ (strings: String[], options: (pattern: String, ignoreCase: Bool)) -> Bool {
    return strings.all { $0 =~ options }
}

//  Match against any element in an array of String
@infix func |~ (strings: String[], pattern: String) -> Bool {
    return strings.any { $0 =~ (pattern: pattern, ignoreCase: false) }
}

@infix func |~ (strings: String[], options: (pattern: String, ignoreCase: Bool)) -> Bool {
    return strings.any { $0 =~ options }
}
