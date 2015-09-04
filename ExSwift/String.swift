//
//  String.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

public extension String {

    /**
        String length
    */
    var length: Int { return self.characters.count }

    /**
        self.capitalizedString shorthand
    */
    var capitalized: String { return capitalizedString }

    /**
        Returns the substring in the given range

        - parameter range:
        - returns: Substring in range
    */
    subscript (range: Range<Int>) -> String? {
        if range.startIndex < 0 || range.endIndex > self.length {
            return nil
        }

        let range = Range(start: startIndex.advancedBy(range.startIndex), end: startIndex.advancedBy(range.endIndex))

        return self[range]
    }

    /**
        Equivalent to at. Takes a list of indexes and returns an Array
        containing the elements at the given indexes in self.

        - parameter firstIndex:
        - parameter secondIndex:
        - parameter restOfIndexes:
        - returns: Charaters at the specified indexes (converted to String)
    */
    subscript (firstIndex: Int, secondIndex: Int, restOfIndexes: Int...) -> [String] {
        return at([firstIndex, secondIndex] + restOfIndexes)
    }

    /**
        Gets the character at the specified index as String.
        If index is negative it is assumed to be relative to the end of the String.

        - parameter index: Position of the character to get
        - returns: Character as String or nil if the index is out of bounds
    */
    subscript (index: Int) -> String? {
        if let char = Array(self.characters).get(index) {
            return String(char)
        }

        return nil
    }

    /**
        Takes a list of indexes and returns an Array containing the elements at the given indexes in self.

        - parameter indexes: Positions of the elements to get
        - returns: Array of characters (as String)
    */
    func at (indexes: Int...) -> [String] {
        return indexes.map { self[$0]! }
    }

    /**
        Takes a list of indexes and returns an Array containing the elements at the given indexes in self.

        - parameter indexes: Positions of the elements to get
        - returns: Array of characters (as String)
    */
    func at (indexes: [Int]) -> [String] {
        return indexes.map { self[$0]! }
    }

    /**
        Returns an array of strings, each of which is a substring of self formed by splitting it on separator.

        - parameter separator: Character used to split the string
        - returns: Array of substrings
    */
    func explode (separator: Character) -> [String] {
      return self.characters.split { $0 == separator }.map { String($0) }
    }

    /**
        Finds any match in self for pattern.

        - parameter pattern: Pattern to match
        - parameter ignoreCase: true for case insensitive matching
        - returns: Matches found (as [NSTextCheckingResult])
    */
    func matches (pattern: String, ignoreCase: Bool = false) throws -> [NSTextCheckingResult]? {

        if let regex = try ExSwift.regex(pattern, ignoreCase: ignoreCase) {
            //  Using map to prevent a possible bug in the compiler
            return regex.matchesInString(self, options: [], range: NSMakeRange(0, length)).map { $0 as NSTextCheckingResult }
        }

        return nil

    }

    /**
    Check is string with this pattern included in string

    - parameter pattern: Pattern to match
    - parameter ignoreCase: true for case insensitive matching
    - returns: true if contains match, otherwise false
    */
    func containsMatch (pattern: String, ignoreCase: Bool = false) throws -> Bool? {
        if let regex = try ExSwift.regex(pattern, ignoreCase: ignoreCase) {
            let range = NSMakeRange(0, self.characters.count)
            return regex.firstMatchInString(self, options: [], range: range) != nil
        }

        return nil
    }

    /**
    Replace all pattern matches with another string
    
    - parameter pattern: Pattern to match
    - parameter replacementString: string to replace matches
    - parameter ignoreCase: true for case insensitive matching
    - returns: true if contains match, otherwise false
    */
    func replaceMatches (pattern: String, withString replacementString: String, ignoreCase: Bool = false) throws -> String? {
        if let regex = try ExSwift.regex(pattern, ignoreCase: ignoreCase) {
            let range = NSMakeRange(0, self.characters.count)
            return regex.stringByReplacingMatchesInString(self, options: [], range: range, withTemplate: replacementString)
        }
        
        return nil
    }
    
    /**
        Inserts a substring at the given index in self.

        - parameter index: Where the new string is inserted
        - parameter string: String to insert
        - returns: String formed from self inserting string at index
    */
    func insert (index: Int, _ string: String) -> String {
        //  Edge cases, prepend and append
        if index > length {
            return self + string
        } else if index < 0 {
            return string + self
        }

        return self[0..<index]! + string + self[index..<length]!
    }

    /**
        Strips the specified characters from the beginning of self.

        - returns: Stripped string
    */
    func trimmedLeft (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet) {
            return self[range.startIndex..<endIndex]
        }

        return ""
    }

    @available(*, unavailable, message="use 'trimmedLeft' instead") func ltrimmed (set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        return trimmedLeft(characterSet: set)
    }

    /**
        Strips the specified characters from the end of self.

        - returns: Stripped string
    */
    func trimmedRight (characterSet set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        if let range = rangeOfCharacterFromSet(set.invertedSet, options: NSStringCompareOptions.BackwardsSearch) {
            return self[startIndex..<range.endIndex]
        }

        return ""
    }

    @available(*, unavailable, message="use 'trimmedRight' instead") func rtrimmed (set: NSCharacterSet = NSCharacterSet.whitespaceAndNewlineCharacterSet()) -> String {
        return trimmedRight(characterSet: set)
    }

    /**
        Strips whitespaces from both the beginning and the end of self.

        - returns: Stripped string
    */
    func trimmed () -> String {
        return trimmedLeft().trimmedRight()
    }

    /**
        Costructs a string using random chars from a given set.

        - parameter length: String length. If < 1, it's randomly selected in the range 0..16
        - parameter charset: Chars to use in the random string
        - returns: Random string
    */
    static func random (var length len: Int = 0, charset: String = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789") -> String {

        if len < 1 {
            len = Int.random(max: 16)
        }

        var result = String()
        let max = charset.length - 1

        len.times {
            result += charset[Int.random(0, max: max)]!
        }

        return result

    }


    /**
        Parses a string containing a double numerical value into an optional double if the string is a well formed number.

        - returns: A double parsed from the string or nil if it cannot be parsed.
    */
    func toDouble() -> Double? {

        let scanner = NSScanner(string: self)
        var double: Double = 0

        if scanner.scanDouble(&double) {
            return double
        }

        return nil

    }

    /**
       Parses a string containing a float numerical value into an optional float if the string is a well formed number.

       - returns: A float parsed from the string or nil if it cannot be parsed.
    */
    func toFloat() -> Float? {

        let scanner = NSScanner(string: self)
        var float: Float = 0

        if scanner.scanFloat(&float) {
            return float
        }

        return nil

    }

    /**
        Parses a string containing a non-negative integer value into an optional UInt if the string is a well formed number.

        - returns: A UInt parsed from the string or nil if it cannot be parsed.
    */
    func toUInt() -> UInt? {
        if let val = Int(self.trimmed()) {
            if val < 0 {
                return nil
            }
            return UInt(val)
        }

        return nil
    }


    /**
      Parses a string containing a boolean value (true or false) into an optional Bool if the string is a well formed.

      - returns: A Bool parsed from the string or nil if it cannot be parsed as a boolean.
    */
    func toBool() -> Bool? {
        let text = self.trimmed().lowercaseString
        if text == "true" || text == "false" || text == "yes" || text == "no" {
            return (text as NSString).boolValue
        }

        return nil
    }

    /**
      Parses a string containing a date into an optional NSDate if the string is a well formed.
      The default format is yyyy-MM-dd, but can be overriden.

      - returns: A NSDate parsed from the string or nil if it cannot be parsed as a date.
    */
    func toDate(format : String? = "yyyy-MM-dd") -> NSDate? {
        let text = self.trimmed().lowercaseString
        let dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        if let fmt = format {
            dateFmt.dateFormat = fmt
        }
        return dateFmt.dateFromString(text)
    }

    /**
      Parses a string containing a date and time into an optional NSDate if the string is a well formed.
      The default format is yyyy-MM-dd hh-mm-ss, but can be overriden.

      - returns: A NSDate parsed from the string or nil if it cannot be parsed as a date.
    */
    func toDateTime(format : String? = "yyyy-MM-dd hh-mm-ss") -> NSDate? {
        return toDate(format)
    }

}

/**
    Repeats the string first n times
*/
public func * (first: String, n: Int) -> String {

    var result = String()

    n.times {
        result += first
    }

    return result

}

//  Pattern matching using a regular expression
public func =~ (string: String, pattern: String) throws -> Bool {

    let regex = try ExSwift.regex(pattern, ignoreCase: false)!
    let matches = regex.numberOfMatchesInString(string, options: [], range: NSMakeRange(0, string.length))

    return matches > 0

}

//  Pattern matching using a regular expression
public func =~ (string: String, regex: NSRegularExpression) -> Bool {

    let matches = regex.numberOfMatchesInString(string, options: [], range: NSMakeRange(0, string.length))

    return matches > 0

}

//  This version also allowes to specify case sentitivity
public func =~ (string: String, options: (pattern: String, ignoreCase: Bool)) throws -> Bool {

    if let matches = try ExSwift.regex(options.pattern, ignoreCase: options.ignoreCase)?.numberOfMatchesInString(string, options: [], range: NSMakeRange(0, string.length)) {
        return matches > 0
    }

    return false

}

//  Match against all the alements in an array of String
public func =~ (strings: [String], pattern: String) throws -> Bool {

    let regex = try ExSwift.regex(pattern, ignoreCase: false)!

    return strings.all { $0 =~ regex }

}

public func =~ (strings: [String], options: (pattern: String, ignoreCase: Bool)) throws -> Bool {

    var lastError: ErrorType?

    let result = strings.all {
        do {
            return try $0 =~ options
        } catch let error {
            lastError = error
            return false
        }
    }
    
    if let error = lastError {
        throw error
    }
    
    return result
    
}

//  Match against any element in an array of String
public func |~ (strings: [String], pattern: String) throws -> Bool {

    let regex = try ExSwift.regex(pattern, ignoreCase: false)!

    return strings.any { $0 =~ regex }

}

public func |~ (strings: [String], options: (pattern: String, ignoreCase: Bool)) throws -> Bool {

    var lastError: ErrorType?
    
    let result = strings.any {
        do {
            return try $0 =~ options
        } catch let error {
            lastError = error
            return false
        }
    }
    
    if let error = lastError {
        throw error
    }
    
    return result

}
