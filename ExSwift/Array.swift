//
//  Array.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

internal extension Array {
    
    private var indexesInterval: HalfOpenInterval<Int> { return HalfOpenInterval<Int>(0, self.count) }
    
    /**
        Checks if self contains a list of items.
    
        :param: items Items to search for
        :returns: true if self contains all the items
    */
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }

    /**
        Difference of self and the input arrays.
    
        :param: values Arrays to subtract
        :returns: Difference of self and the input arrays
    */
    func difference <T: Equatable> (values: [T]...) -> [T] {

        var result = [T]()

        elements: for e in self {
            if let element = e as? T {
                for value in values {
                    //  if a value is in both self and one of the values arrays
                    //  jump to the next iteration of the outer loop
                    if value.contains(element) {
                        continue elements
                    }
                }

                //  element it's only in self
                result.append(element)
            }
        }

        return result

    }

    /**
        Intersection of self and the input arrays.
    
        :param: values Arrays to intersect
        :returns: Array of unique values contained in all the dictionaries and self
    */
    func intersection <U: Equatable> (values: [U]...) -> Array {

        var result = self
        var intersection = Array()

        for (i, value) in enumerate(values) {

            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if (i > 0) {
                result = intersection
                intersection = Array()
            }

            //  find common elements and save them in first set
            //  to intersect in the next loop
            value.each { (item: U) -> Void in
                if result.contains(item) {
                    intersection.append(item as Element)
                }
            }

        }

        return intersection

    }

    /**
        Union of self and the input arrays.
        
        :param: values Arrays
        :returns: Union array of unique values
    */
    func union <U: Equatable> (values: [U]...) -> Array {

        var result = self

        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as Element)
                }
            }
        }

        return result

    }

    /**
        First element of the array.
        
        :returns: First element of the array if not empty
    */
    @availability(*, unavailable, message="use the 'first' property instead") func first () -> Element? {
        return first
    }

    /**
        Last element of the array.
    
        :returns: Last element of the array if not empty
    */
    @availability(*, unavailable, message="use the 'last' property instead") func last () -> Element? {
        return last
    }

    /**
        Index of the first occurrence of item, if found.
    
        :param: item The item to search for
        :returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return find(unsafeBitCast(self, [U].self), item)
        }

        return nil
    }
    
    /**
        Index of the first item that meets the condition.
    
        :param: condition A function which returns a boolean if an element satisfies a given condition or not.
        :returns: Index of the first matched item or nil
    */
    func indexOf (condition: Element -> Bool) -> Int? {
        for (index, element) in enumerate(self) {
            if condition(element) {
                return index
            }
        }
        
        return nil
    }

    /**
        Gets the index of the last occurrence of item, if found.
    
        :param: item The item to search for
        :returns: Index of the matched item or nil
    */
    func lastIndexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            for (index, value) in enumerate(lazy(self).reverse()) {
                if value as U == item {
                    return count - 1 - index
                }
            }

            return nil
        }

        return nil
    }

    /**
        Gets the object at the specified index, if it exists.
        
        :param: index
        :returns: Object at index in self
    */
    func get (index: Int) -> Element? {

        //  If the index is out of bounds it's assumed relative
        func relativeIndex (index: Int) -> Int {
            var _index = (index % count)

            if _index < 0 {
                _index = count + _index
            }

            return _index
        }

        let _index = relativeIndex(index)
        return _index < count ? self[_index] : nil
    }

    /**
        Gets the objects in the specified range.
    
        :param: range
        :returns: Subarray in range
    */
    func get (range: Range<Int>) -> Array {
        return self[rangeAsArray: range]
    }

    /**
        Returns an array of grouped elements, the first of which contains the first elements
        of the given arrays, the 2nd contains the 2nd elements of the given arrays, and so on.
    
        :param: arrays Arrays to zip
        :returns: Array of grouped elements
    */
    func zip (arrays: [Any]...) -> [[Any?]] {

        var result = [[Any?]]()

        //  Gets the longest array length
        let max = arrays.map { (array: [Any]) -> Int in
            return array.count
        }.max() as Int

        for i in 0..<max {

            //  i-th element in self as array + every i-th element in each array in arrays
            result.append([get(i)] + arrays.map { (array) -> Any? in
                return array.get(i)
            })

        }

        return result
    }

    /**
        Produces an array of arrays, each containing n elements, each offset by step.
        If the final partition is not n elements long it is dropped.
    
        :param: n The number of elements in each partition.
        :param: step The number of elements to progress between each partition.  Set to n if not supplied.
        :returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil) -> [Array] {
        var result = [Array]()
        
        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }

        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.
        if n > count { return [[]] }

        for i in stride(from: 0, through: count - n, by: step!) {
            result += [self[i..<(i + n)]]
        }

        return result
    }

    /**
        Produces an array of arrays, each containing n elements, each offset by step.
        
        :param: n The number of elements in each partition.
        :param: step The number of elements to progress between each partition.  Set to n if not supplied.
        :param: pad An array of elements to pad the last partition if it is not long enough to
                    contain n elements. If nil is passed or there are not enough pad elements
                    the last partition may less than n elements long.
        :returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil, pad: Array?) -> [Array] {
        var result = [Array]()
        
        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }

        // Less than 1 results in an infinite loop.
        if step < 1 {
            step = 1
        }
        
        // Allow 0 if user wants [[],[],[]] for some reason.
        if n < 1 {
            n = 0
        }
        
        for i in stride(from: 0, to: count, by: step!) {
            var end = i + n
            
            if end > count {
                end = count
            }
            
            result += [self[i..end]]
            
            if end != i + n {
                break
            }
        }

        if let padding = pad {
            let remaining = count % n
            result[result.count - 1] += padding[0..<remaining] as Array
        }

        return result
    }

    /**
        Produces an array of arrays, each containing n elements, each offset by step.
    
        :param: n The number of elements in each partition.
        :param: step The number of elements to progress between each partition. Set to n if not supplied.
        :returns: Array partitioned into n element arrays, starting step elements apart.
    */
    func partitionAll (var n: Int, var step: Int? = nil) -> [Array] {
        var result = [Array]()

        // If no step is supplied move n each step.
        if step == nil {
            step = n
        }

        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.

        for i in stride(from: 0, to: count, by: step!) {
            result += [self[i..(i + n)]]
        }

        return result
    }

    /**
        Applies cond to each element in array, splitting it each time cond returns a new value.
        
        :param: cond Function which takes an element and produces an equatable result.
        :returns: Array partitioned in order, splitting via results of cond.
    */
    func partitionBy <T: Equatable> (cond: (Element) -> T) -> [Array] {
        var result = [Array]()
        var lastValue: T? = nil

        for item in self {
            let value = cond(item)

            if value == lastValue? {
                let index: Int = result.count - 1
                result[index] += [item]
            } else {
                result.append([item])
                lastValue = value
            }
        }

        return result
    }

    /**
        Randomly rearranges the elements of self using the Fisher-Yates shuffle
    */
    mutating func shuffle () {

        for var i = self.count - 1; i >= 1; i-- {
            let j = Int.random(max: i)
            swap(&self[i], &self[j])
        }

    }

    /**
        Shuffles the values of the array into a new one
        
        :returns: Shuffled copy of self
    */
    func shuffled () -> Array {
        var shuffled = self
        
        shuffled.shuffle()

        return shuffled
    }

    /**
        Returns a random subarray of given length.
    
        :param: n Length
        :returns: Random subarray of length n
    */
    func sample (size n: Int = 1) -> Array {
        if n >= count {
            return self
        }

        let index = Int.random(max: count - n)
        return self[index..<(n + index)]
    }

    /**
        Max value in the current array (if Array.Element implements the Comparable protocol).
    
        :returns: Max value
    */
    func max <U: Comparable> () -> U {

        return maxElement(map {
            return $0 as U
        })

    }

    /**
        Min value in the current array (if Array.Element implements the Comparable protocol).
    
        :returns: Min value
    */
    func min <U: Comparable> () -> U {

        return minElement(map {
            return $0 as U
        })

    }

    /**
        The value for which call(value) is highest.

        :returns: Max value in terms of call(value)
    */
    func maxBy <U: Comparable> (call: (Element) -> (U)) -> Element? {

        if let firstValue = self.first {
            var maxElement: T = firstValue
            var maxValue: U = call(firstValue)
            for i in 1..<self.count {
                let element: Element = self[i]
                let value: U = call(element)
                if value > maxValue {
                    maxElement = element
                    maxValue = value
                }
            }
            return maxElement
        } else {
            return nil
        }

    }

    /**
        The value for which call(value) is lowest.

        :returns: Min value in terms of call(value)
    */
    func minBy <U: Comparable> (call: (Element) -> (U)) -> Element? {

        if let firstValue = self.first {
            var maxElement: T = firstValue
            var minValue: U = call(firstValue)
            for i in 1..<self.count {
                let element: Element = self[i]
                let value: U = call(element)
                if value < minValue {
                    maxElement = element
                    minValue = value
                }
            }
            return maxElement
        } else {
            return nil
        }

    }

    /**
        Iterates on each element of the array.
    
        :param: call Function to call for each element
    */
    func each (call: (Element) -> ()) {

        for item in self {
            call(item)
        }

    }

    /**
        Iterates on each element of the array with its index.
    
        :param: call Function to call for each element
    */
    func each (call: (Int, Element) -> ()) {

        for (index, item) in enumerate(self) {
            call(index, item)
        }

    }

    /**
        Iterates on each element of the array from Right to Left.
    
        :param: call Function to call for each element
    */
    func eachRight (call: (Element) -> ()) {
        reverse().each(call)
    }

    /**
        Iterates on each element of the array, with its index, from Right to Left.
    
        :param: call Function to call for each element
    */
    func eachRight (call: (Int, Element) -> ()) {
        for (index, item) in enumerate(reverse()) {
            call(count - index - 1, item)
        }
    }

    /**
        Checks if test returns true for any element of self.
    
        :param: test Function to call for each element
        :returns: true if test returns true for any element of self
    */
    func any (test: (Element) -> Bool) -> Bool {
        for item in self {
            if test(item) {
                return true
            }
        }

        return false
    }

    /**
        Checks if test returns true for all the elements in self
    
        :param: test Function to call for each element
        :returns: True if test returns true for all the elements in self
    */
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }

        return true
    }

    /**
        Opposite of filter.
    
        :param: exclude Function invoked to test elements for the exclusion from the array
        :returns: Filtered array
    */
    func reject (exclude: (Element -> Bool)) -> Array {
        return filter {
            return !exclude($0)
        }
    }

    /**
        Returns an array containing the first n elements of self.
    
        :param: n Number of elements to take
        :returns: First n elements
    */
    func take (n: Int) -> Array {
        return self[0..<Swift.max(0, n)]
    }

    /**
        Returns the elements of the array up until an element does not meet the condition.
    
        :param: condition A function which returns a boolean if an element satisfies a given condition or not.
        :returns: Elements of the array up until an element does not meet the condition
    */
    func takeWhile (condition: (Element) -> Bool) -> Array {

        var lastTrue = -1

        for (index, value) in enumerate(self) {
            if condition(value) {
                lastTrue = index
            } else {
                break
            }
        }

        return take(lastTrue + 1)
    }

    /**
        Returns the first element in the array to meet the condition.
    
        :param: condition A function which returns a boolean if an element satisfies a given condition or not.
        :returns: The first element in the array to meet the condition
    */
    func takeFirst (condition: (Element) -> Bool) -> Element? {
        
        for value in self {
            if condition(value) {
                return value
            }
        }
        
        return nil
        
    }
    
    /**
        Returns an array containing the the last n elements of self.
    
        :param: n Number of elements to take
        :returns: Last n elements
    */
    func tail (n: Int) -> Array {
        return self[(count - n)..<count]
    }

    /**
        Subarray from n to the end of the array.
    
        :param: n Number of elements to skip
        :returns: Array from n to the end
    */
    func skip (n: Int) -> Array {
        return n > count ? [] : self[n..<count]
    }

    /**
        Skips the elements of the array up until the condition returns false.

        :param: condition A function which returns a boolean if an element satisfies a given condition or not
        :returns: Elements of the array starting with the element which does not meet the condition
    */
    func skipWhile (condition: (Element) -> Bool) -> Array {

        var lastTrue = -1

        for (index, value) in enumerate(self) {
            if condition(value) {
                lastTrue = index
            } else {
                break
            }
        }

        return skip(lastTrue + 1)
    }

    /**
        Costructs an array removing the duplicate values in self
        if Array.Element implements the Equatable protocol.
    
        :returns: Array of unique values
    */
    func unique <T: Equatable> () -> [T] {
        var result = [T]()

        for item in self {
            if !result.contains(item as T) {
                result.append(item as T)
            }
        }

        return result
    }

    /**
        Returns the set of elements for which call(element) is unique
		
		:param: call The closure to use to determine uniqueness
		:returns: The set of elements for which call(element) is unique
    */
    func uniqueBy <T: Equatable> (call: (Element) -> (T)) -> [Element] {
        var result: [Element] = []
        var uniqueItems: [T] = []

        for item in self {
            var callResult: T = call(item)
            if !uniqueItems.contains(callResult) {
                uniqueItems.append(callResult)
                result.append(item)
            }
        }

        return result
    }

    /**
        Creates a dictionary composed of keys generated from the results of
        running each element of self through groupingFunction. The corresponding
        value of each key is an array of the elements responsible for generating the key.
    
        :param: groupingFunction
        :returns: Grouped dictionary
    */
    func groupBy <U> (groupingFunction group: (Element) -> U) -> [U: Array] {

        var result = [U: Array]()

        for item in self {

            let groupKey = group(item)

            // If element has already been added to dictionary, append to it. If not, create one.
            if result.has(groupKey) {
                result[groupKey]! += [item]
            } else {
                result[groupKey] = [item]
            }
        }

        return result
    }

    /**
        Similar to groupBy, instead of returning a list of values,
        returns the number of values for each group.
    
        :param: groupingFunction
        :returns: Grouped dictionary
    */
    func countBy <U> (groupingFunction group: (Element) -> U) -> [U: Int] {

        var result = [U: Int]()

        for item in self {
            let groupKey = group(item)

            if result.has(groupKey) {
                result[groupKey]!++
            } else {
                result[groupKey] = 1
            }
        }

        return result
    }

    /**
        Returns the number of elements which meet the condition

        :param: test Function to call for each element
        :returns: the number of elements meeting the condition
    */
    func countWhere (test: (Element) -> Bool) -> Int {

        var result = 0

        for item in self {
            if test(item) {
                result++
            }
        }

        return result
    }

    /**
        Joins the array elements with a separator.

        :param: separator
        :return: Joined object if self is not empty and its elements are instances of C, nil otherwise
    */
    func implode <C: ExtensibleCollectionType> (separator: C) -> C? {
        if Element.self is C.Type {
            return Swift.join(separator, unsafeBitCast(self, [C].self))
        }

        return nil
    }

    
    /**
        Creates an array with values generated by running each value of self 
        through the mapFunction and discarding nil return values.
    
        :param: mapFunction
        :returns: Mapped array
    */
    func mapFilter <V> (mapFunction map: (Element) -> (V)?) -> [V] {
        
        var mapped = [V]()
        
        each { (value: Element) -> Void in
            if let mappedValue = map(value) {
                mapped.append(mappedValue)
            }
        }
        
        return mapped
        
    }
    
    /**
        self.reduce with initial value self.first()
    */
    func reduce (combine: (Element, Element) -> Element) -> Element? {
        if let firstElement = first {
            return skip(1).reduce(firstElement, combine: combine)
        }
        
        return nil
    }

    /**
        self.reduce from right to left
    */
    func reduceRight <U> (initial: U, combine: (U, Element) -> U) -> U {
        return reverse().reduce(initial, combine: combine)
    }

    /**
        self.reduceRight with initial value self.last()
    */
    func reduceRight (combine: (Element, Element) -> Element) -> Element? {
        return reverse().reduce(combine)
    }

    /**
        Creates an array with the elements at the specified indexes.
    
        :param: indexes Indexes of the elements to get
        :returns: Array with the elements at indexes
    */
    func at (indexes: Int...) -> Array {
        return indexes.map { self.get($0)! }
    }

    /**
        Converts the array to a dictionary with the keys supplied via the keySelector.
    
        :param: keySelector
        :returns: A dictionary
    */
    func toDictionary <U> (keySelector:(Element) -> U) -> [U: Element] {
        var result: [U: Element] = [:]
        for item in self {
            result[keySelector(item)] = item
        }

        return result
    }

    /**
        Flattens a nested Array self to an array of OutType objects.
    
        :returns: Flattened array
    */
    func flatten <OutType> () -> [OutType] {
        var result = [OutType]()
        let reflection = reflect(self)
        
        for i in 0..<reflection.count {
            result += Ex.bridgeObjCObject(reflection[i].1.value) as [OutType]
        }
        
        return result
    }
    
    /**
        Flattens a nested Array self to an array of AnyObject.
    
        :returns: Flattened array
    */
    func flattenAny () -> [AnyObject] {
        var result = [AnyObject]()
        
        for item in self {
            if let array = item as? NSArray {
                result += array.flattenAny()
            } else if let object = item as? NSObject {
                result.append(object)
            }
        }
        
        return result
    }

    /**
        Sorts the array according to the given comparison function.
    
        :param: isOrderedBefore Comparison function.
        :returns: An array that is sorted according to the given function
    */
    func sortBy (isOrderedBefore: (T, T) -> Bool) -> [T] {
        return sorted(isOrderedBefore)
    }

    /**
        Removes the last element from self and returns it.
    
        :returns: The removed element
    */
    mutating func pop () -> Element {
        return removeLast()
    }

    /**
        Same as append.
        
        :param: newElement Element to append
    */
    mutating func push (newElement: Element) {
        return append(newElement)
    }

    /**
        Returns the first element of self and removes it from the array.
    
        :returns: The removed element
    */
    mutating func shift () -> Element {
        return removeAtIndex(0)
    }

    /**
        Prepends an object to the array.
    
        :param: newElement Object to prepend
    */
    mutating func unshift (newElement: Element) {
        insert(newElement, atIndex: 0)
    }
    
    /**
        Inserts an array at a given index in self.
    
        :param: newArray Array to insert
        :param: atIndex Where to insert the array
    */
    mutating func insert (newArray: Array, atIndex: Int) {
        self = take(atIndex) + newArray + skip(atIndex)
    }

    /**
        Deletes all the items in self that are equal to element.
    
        :param: element Element to remove
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self

        removeAll(keepCapacity: true)

        anotherSelf.each {
            (index: Int, current: Element) in
            if current as U != element {
                self.append(current)
            }
        }
    }

    /**
        Constructs an array containing the values in the given range.
    
        :param: range
        :returns: Array of values
    */
    static func range <U: ForwardIndexType> (range: Range<U>) -> [U] {
        return [U](range)
    }

    /**
        Returns the subarray in the given range.
        
        :param: range Range of the subarray elements
        :returns: Subarray or nil if the index is out of bounds
    */
    subscript (#rangeAsArray: Range<Int>) -> Array {
        //  Fix out of bounds indexes
        let start = Swift.max(0, rangeAsArray.startIndex)
        let end = Swift.min(rangeAsArray.endIndex, count)
        
        if start > end {
            return []
        }
            
        return Array(self[Range(start: start, end: end)] as Slice<T>)
    }

    /**
        Returns a subarray whose items are in the given interval in self.
    
        :param: interval Interval of indexes of the subarray elements
        :returns: Subarray or nil if the index is out of bounds
    */
    subscript (interval: HalfOpenInterval<Int>) -> Array {
        return self[rangeAsArray: Range(start: interval.start, end: interval.end)]
    }
    
    /**
        Returns a subarray whose items are in the given interval in self.
    
        :param: interval Interval of indexes of the subarray elements
        :returns: Subarray or nil if the index is out of bounds
    */
    subscript (interval: ClosedInterval<Int>) -> Array {
        return self[rangeAsArray: Range(start: interval.start, end: interval.end + 1)]
    }
    
    /**
        Creates an array with the elements at indexes in the given list of integers.
    
        :param: first First index
        :param: second Second index
        :param: rest Rest of indexes
        :returns: Array with the items at the specified indexes
    */
    subscript (first: Int, second: Int, rest: Int...) -> Array {
        let indexes = [first, second] + rest
        return indexes.map { self[$0] }
    }

}

/**
    Remove an element from the array
*/
public func - <T: Equatable> (first: Array<T>, second: T) -> Array<T> {
    return first - [second]
}

/**
    Difference operator
*/
public func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.difference(second)
}

/**
    Intersection operator
*/
public func & <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.intersection(second)
}

/**
    Union operator
*/
public func | <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.union(second)
}
/**
    Array duplication.

    :param: array Array to duplicate
    :param: n How many times the array must be repeated
    :returns: Array of repeated values
*/
public func * <ItemType> (array: Array<ItemType>, n: Int) -> Array<ItemType> {
    var result = Array<ItemType>()

    n.times {
        result += array
    }

    return result
}

/**
    Array items concatenation à la Ruby.

    :param: array Array of Strings to join
    :param: separator Separator to join the array elements
    :returns: Joined string
*/
public func * (array: Array<String>, separator: String) -> String {
    return array.implode(separator)!
}
