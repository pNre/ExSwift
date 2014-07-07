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
    *  @param range
    *  @return Substring in range
    */
    subscript (range: Range<Int>) -> String? {
        return Array(self).get(range).reduce(String(), +)
    }

    /**
    *  Equivalent to at
    *  @param indexes
    *  @return Charaters at the specified indexes (converted to String)
    */
    subscript (indexes: Int...) -> Array<String> {
        return at(indexes)
    }

    /**
    *  Gets the character at the specified index (converted to String)
    *  @param index
    *  @return Unicode char as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
        if let char = Array(self).get(index) {
            return String(char)
        }

        return nil
    }

    /**
    *  Returns the characters at the specified indexes
    *  @param indexes
    *  @return Array of characters (as String)
    */
    func at (indexes: Int...) -> Array<String> {
        return indexes.map { self[$0]! }
    }

    /**
    *  Returns the characters at the specified indexes
    *  @param indexes
    *  @return Array of characters (as String)
    */
    func at (indexes: Array<Int>) -> Array<String> {
        return indexes.map { self[$0]! }
    }

    /**
    *  Returns an array of strings, each of which is a substring of self formed by splitting it on separator
    *  @param separator
    *  @return Array of strings
    */
    func explode (separator: Character) -> Array<String> {
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
    func matches (pattern: String, ignoreCase: Bool = false) -> Array<NSTextCheckingResult>? {

        if let regex = ExSwift.regex(pattern, ignoreCase: ignoreCase) {
            return regex.matchesInString(self, options: nil, range: NSMakeRange(0, length)) as? Array<NSTextCheckingResult>
        }

        return nil
    }

    /**
    *  Capitalizes the first character in the string
    *  @return Capitalized String
    */
    func capitalized () -> String {
        return capitalizedString
    }

    /**
    *  Inserts a substring at the given index
    *  @param index Where the new string is inserted
    *  @param string String to insert
    *  @return String formed with string at the given index
    */
    func insert (index: Int, _ string: String) -> String {
        return self[0..<index]! + string + self[index..<length]!
    }

    /**
    *  Strip whitespaces from the start of a string
    *  @return Stripped string
    */
    func ltrimmed () -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet) {
            return self[range.startIndex..<endIndex]
        }
        
        return self
    }

    /**
    *  Strip whitespaces from the end of a string
    *  @return Stripped string
    */
    func rtrimmed () -> String {
        if let range = rangeOfCharacterFromSet(NSCharacterSet.whitespaceAndNewlineCharacterSet().invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }
        
        return self
    }

    /**
    *  Strip whitespaces from both the start and the end of a string
    *  @return Stripped string
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
@infix func =~ (strings: Array<String>, pattern: String) -> Bool {
    return strings.all { $0 =~ (pattern: pattern, ignoreCase: false) }
}

@infix func =~ (strings: Array<String>, options: (pattern: String, ignoreCase: Bool)) -> Bool {
    return strings.all { $0 =~ options }
}

//  Match against any element in an array of String
@infix func |~ (strings: Array<String>, pattern: String) -> Bool {
    return strings.any { $0 =~ (pattern: pattern, ignoreCase: false) }
}

@infix func |~ (strings: Array<String>, options: (pattern: String, ignoreCase: Bool)) -> Bool {
    return strings.any { $0 =~ options }
}
