//
//  Array.swift
//  ExSwift
//
//  Created by pNre on 03/06/14.
//  Copyright (c) 2014 pNre. All rights reserved.
//

import Foundation

extension Array {

    /**
    *  Checks if self contains the item object
    *  @param item The item to search for
    *  @return true if self contains item
    */
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }

    /**
    *  Difference of self and the input arrays
    *  @param values Arrays to subtract
    *  @return Difference of self and the input arrays
    */
    func difference <T: Equatable> (values: Array<T>...) -> Array<T> {

        var result = Array<T>()

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
    *  Intersection of self and the input arrays
    *  @param values Arrays to intersect
    *  @return Array of unique values present in all the values arrays + self
    */
    func intersection <U: Equatable> (values: Array<U>...) -> Array {

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
    *  Union of self and the input arrays
    *  @param values Arrays
    *  @return Union array of unique values
    */
    func union <U: Equatable> (values: Array<U>...) -> Array {

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
    *  First element of the array
    *  @return First element of the array if present
    */
    func first () -> Element? {
        if count > 0 {
            return self[0]
        }
        return nil
    }

    /**
    *  Last element of the array
    *  @return Last element of the array if present
    */
    func last () -> Element? {
        if count > 0 {
            return self[count - 1]
        }
        return nil
    }

    /**
    *  Index of the first occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            if let found = find(reinterpretCast(self) as Array<U>, item) {
                return found
            }

            return nil
        }

        return nil
    }

    /**
    *  Gets the index of the last occurrence of item, if found
    *  @param item The item to search for
    *  @return Index of the matched item or nil
    */
    func lastIndexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            if let index = reverse().indexOf(item) {
                return count - index - 1
            }

            return nil
        }

        return nil
    }

    /**
    *  Object at the specified index if exists
    *  @param index
    *  @return Object at index in array, nil if index is out of bounds
    */
    func get (index: Int) -> Element? {

        //  Fixes out of bounds values integers
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
    *  Objects in the specified range
    *  @param range
    *  @return Subarray in range
    */
    func get (range: Range<Int>) -> Array {
        return self[range]
    }

    /**
    *  Array of grouped elements, the first of which contains the first elements
    *  of the given arrays, the 2nd contains the 2nd elements of the given arrays, and so on
    *  @param arrays Arrays to zip
    *  @return Array of grouped elements
    */
    func zip (arrays: Array<Any>...) -> Array<Array<Any?>> {

        var result = Array<Array<Any?>>()

        //  Gets the longest array
        let max = arrays.map { (array: Array<Any>) -> Int in
            return array.count
        }.max() as Int

        for i in 0..max {

            //  i-th element in self as array + every i-th element in each array in arrays
            result.append([get(i)] + arrays.map {
                (array: Array<Any>) -> Any? in return array.get(i)
            })

        }

        return result
    }

    /**
    *  Produces an array of arrays, each containing n elements, each offset by step.
    *  If the final partition is not n elements long it is dropped.
    *  @param n The number of elements in each partition.
    *  @param step The number of elements to progress between each partition.  Set to n if not supplied.
    *  @return Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil) -> Array<Array<Element>> {
        var result = Array<Array<Element>>()
        if !step?   { step = n } // If no step is supplied move n each step.
        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.
        if n > count { return [[]] }

        for i in (0...count-n).by(step!) {
            result += self[i..(i+n)]
        }

        return result
    }

    /**
    *  Produces an array of arrays, each containing n elements, each offset by step.
    *  @param n The number of elements in each partition.
    *  @param step The number of elements to progress between each partition.  Set to n if not supplied.
    *  @param pad An array of elements to pad the last partition if it is not long enough to
    *             contain n elements. If nil is passed or there are not enough pad elements
    *             the last partition may less than n elements long.
    *  @return Array partitioned into n element arrays, starting step elements apart.
    */
    func partition (var n: Int, var step: Int? = nil, pad: Element[]?) -> Array<Array<Element>> {
        var result = Array<Array<Element>>()
        if !step?   { step = n } // If no step is supplied move n each step.
        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.

        for i in (0..count).by(step!) {
            var end = i+n
            if end > count { end = count }
            result += self[i..end]
            if end != i+n { break }
        }

        if let padding = pad {
            let remaining = count % n
            result[result.count-1] += padding[0..remaining] as Element[]
        }

        return result
    }

    /**
    *  Produces an array of arrays, each containing n elements, each offset by step.
    *  @param n The number of elements in each partition.
    *  @param step The number of elements to progress between each partition.  Set to n if not supplied.
    *  @return Array partitioned into n element arrays, starting step elements apart.
    */
    func partitionAll (var n: Int, var step: Int? = nil) -> Array<Array<Element>> {
        var result = Array<Array<Element>>()
        if !step?   { step = n } // If no step is supplied move n each step.
        if step < 1 { step = 1 } // Less than 1 results in an infinite loop.
        if n < 1    { n = 0 }    // Allow 0 if user wants [[],[],[]] for some reason.

        for i in (0..count).by(step!) {
            result += self[i..i+n]
        }

        return result
    }

    /**
    *  Applies cond to each element in array, splitting it each time cond returns a new value.
    *  @param cond Function which takes an element and produces an equatable result.
    *  @return Array partitioned in order, splitting via results of cond.
    */
    func partitionBy <T: Equatable> (cond: (Element) -> T) -> Array<Array<Element>> {
        var result = Array<Array<Element>>()
        var lastValue: T? = nil

        for item in self {
            let value = cond(item)

            if value == lastValue? {
                result[result.count-1] += item
            } else {
                result.append([item])
                lastValue = value
            }
        }

        return result
    }

    /**
    *  Randomly rearranges the elements of self using the Fisher-Yates shuffle
    */
    mutating func shuffle () {

        for var i = self.count - 1; i >= 1; i-- {
            let j = Int.random(max: i)
            swap(&self[i], &self[j])
        }

    }

    /**
    *  Shuffles the values of the array into a new one
    *  @return Shuffled copy of self
    */
    func shuffled () -> Array {
        var shuffled = self
        shuffled.unshare()
        shuffled.shuffle()

        return shuffled
    }

    /**
    *  Returns a random subarray of length n
    *  @param n Length
    *  @return Random subarray of length n
    */
    func sample (size n: Int = 1) -> Array {
        if n >= count {
            return self
        }

        let index = Int.random(max: count - n)
        return self[index..(n + index)]
    }

    /**
    *  Max value in the current array (if applicable)
    *  @return Max value
    */
    func max <U: Comparable> () -> U {

        return maxElement(map {
            return $0 as U
        })

    }

    /**
    *  Min value in the current array (if applicable)
    *  @return Min value
    */
    func min <U: Comparable> () -> U {

        return minElement(map {
            return $0 as U
        })

    }

    /**
    *  Iterates on each element
    *  @param call Function to call for each element
    */
    func each (call: (Element) -> ()) {

        for item in self {
            call(item)
        }

    }

    /**
    *  Iterates on each element with its index
    *  @param call Function to call for each element
    */
    func each (call: (Int, Element) -> ()) {

        for (index, item) in enumerate(self) {
            call(index, item)
        }

    }

    /**
    *  Same as each, from Right to Left
    *  @param call Function to call for each element
    */
    func eachRight (call: (Element) -> ()) {
        self.reverse().each(call)
    }

    /**
    *  Same as each (with index), from Right to Left
    *  @param call Function to call for each element
    */
    func eachRight (call: (Int, Element) -> ()) {
        for (index, item) in enumerate(self.reverse()) {
            call(count - index - 1, item)
        }
    }

    /**
    *  Checks if call returns true for any element of self
    *  @param call Function to call for each element
    *  @return True if call returns true for any element of self
    */
    func any (call: (Element) -> Bool) -> Bool {
        for item in self {
            if call(item) {
                return true
            }
        }

        return false
    }

    /**
    *  Checks if call returns true for all the elements in self
    *  @param call Function to call for each element
    *  @return True if call returns true for all the elements in self
    */
    func all (call: (Element) -> Bool) -> Bool {
        for item in self {
            if !call(item) {
                return false
            }
        }

        return true
    }

    /**
    *  Opposite of filter
    *  @param exclude Function invoked to test elements from the exclusion from the array
    *  @return Filtered array
    */
    func reject (exclude: (Element -> Bool)) -> Array {
        return filter {
            return !exclude($0)
        }
    }

    /**
    *  Returns the first n elements from self
    *  @return First n elements
    */
    func take (n: Int) -> Array {
        return self[0..n]
    }

    /**
    *  Returns the elements of the array up until an element does not meet the condition
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not.
    *  @return Elements of the array up until an element does not meet the condition
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

        return self.take(lastTrue+1)
    }

    /**
    *  Array with the last n elements of self
    *  @return Last n elements
    */
    func tail (n: Int) -> Array {
        return self[(count - n)..count]
    }

    /**
    *  Subarray from n to the end of the array
    *  @return Array from n to the end
    */
    func skip (n: Int) -> Array {
        return self[n..count]
    }

    /**
    *  Skips the elements of the array up until the condition returns false
    *  @param condition A function which returns a boolean if an element satisfies a given condition or not
    *  @return Elements of the array starting with the element which does not meet the condition
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

        return self.skip(lastTrue+1)
    }

    /**
    *  New array obtanined by removing the duplicate values (if applicable)
    *  @return Unique array
    */
    func unique <T: Equatable> () -> Array<T> {
        var result = Array<T>()

        for item in self {
            if !result.contains(item as T) {
                result.append(item as T)
            }
        }

        return result
    }

    /**
    *  Creates a dictionary composed of keys generated from the results of
    *  running each element of self through groupingFunction. The corresponding
    *  value of each key is an array of the elements responsible for generating the key.
    *  @param groupingFunction
    *  @return Grouped dictionary
    */
    func groupBy <U> (groupingFunction group: (Element) -> U) -> Dictionary<U, Array> {

        var result = Dictionary<U, Element[]>()

        for item in self {

            let groupKey = group(item)

            // If element has already been added to dictionary, append to it. If not, create one.
            if let elem = result[groupKey] {
                result[groupKey] = elem + [item]
            } else {
                result[groupKey] = [item]
            }
        }

        return result
    }

    /**
    *  Similar to groupBy, but instead of returning a list of values,
    *  returns the number of values for each group
    *  @param groupingFunction
    *  @return Grouped dictionary
    */
    func countBy <U> (groupingFunction group: (Element) -> U) -> Dictionary<U, Int> {

        var result = Dictionary<U, Int>()

        for item in self {
            let groupKey = group(item)

            if let elem = result[groupKey] {
                result[groupKey] = elem + 1
            } else {
                result[groupKey] = 1
            }
        }

        return result
    }

    /**
     *  Joins the array elements with a separator
     *  @param separator
     *  @return Joined object if self is not empty
     *          and its elements are instances of C, nil otherwise
     */
    func implode <C: ExtensibleCollection> (separator: C) -> C? {
        if Element.self is C.Type {
            return Swift.join(separator, reinterpretCast(self) as Array<C>)
        }

        return nil
    }

    /**
    *  self.reduce with initial value self.first()
    */
    func reduce (combine: (Element, Element) -> Element) -> Element {
        return skip(1).reduce(first()!, combine: combine)
    }

    /**
    *  self.reduce from right to left
    */
    func reduceRight <U> (initial: U, combine: (U, Element) -> U) -> U {
        return reverse().reduce(initial, combine: combine)
    }

    /**
    *  self.reduceRight with initial value self.last()
    */
    func reduceRight (combine: (Element, Element) -> Element) -> Element {
        return reverse().reduce(combine)
    }

    /**
    *  Creates an array with the elements at the specified indexes
    *  @param indexes Indexes of the elements to get
    *  @return Array with the elements at indexes
    */
    func at (indexes: Int...) -> Array {
        return indexes.map { self.get($0)! }
    }

    /**
    *  Converts the array to a dictionary with the keys supplied via the keySelector
    *  @param keySelector
    *  @return A dictionary
    */
    func toDictionary <U> (keySelector:(Element) -> U) -> Dictionary<U, Element> {
        var result: Dictionary<U, Element> = [:]
        for item in self {
            let key = keySelector(item)
            result[key] = item
        }
        return result
    }

    /**
    *  Flattens the nested Array self to an array of OutType objects
    *  @return Flattened array
    */
    func flatten <OutType> () -> OutType[] {

        //  There's still some work to do here

        var result = OutType[]()

        for item in self {

            if item is OutType {
                result.append(item as OutType)
                continue
            } else if let bridged = bridgeFromObjectiveC(reinterpretCast(item), OutType.self) {
                result.append(bridged)
                continue
            } else if item is NSArray {
                result += (item as NSArray).flatten() as OutType[]
                continue
            }

            let m = reflect(item)
            if m.disposition == MirrorDisposition.IndexContainer {
                for index in 0..m.count {
                    let value = m[index].1.value
                    if value is OutType {
                        result.append(value as OutType)
                        continue
                    }
                }
            }

        }

        return result

    }

    /**
    *  Sorts the array by the given comparison function
    *  @param isOrderedBefore
    *  @return An array that is sorted by the given function
    */
    func sortBy (isOrderedBefore: (T, T) -> Bool) -> Array<T> {
        var clone = self
        clone.unshare()
        clone.sort(isOrderedBefore)
        return clone
    }


    /**
    *  Removes the last element from self and returns it
    *  @return The removed element
    */
    mutating func pop () -> Element {
        return self.removeLast()
    }

    /**
    *  Same as append
    *  @param newElement Element to append
    */
    mutating func push (newElement: Element) {
        return self.append(newElement)
    }

    /**
    *  Returns the first element of self and removes it
    *  @return The removed element
    */
    mutating func shift () -> Element {
        return self.removeAtIndex(0)
    }

    /**
    *  Prepends objects to the front of self
    */
    mutating func unshift (newElement: Element) {
        self.insert(newElement, atIndex: 0)
    }
    
    /**
    *  Inserts an array at index
    *  @param newArray Array to insert
    *  @param atIndex Where the array has to be inserted
    */
    mutating func insert (newArray: Array, atIndex: Int) {
        self = self.take(atIndex) + newArray + self.skip(atIndex)
    }

    /**
    *  Deletes all the items in self that are equal to element
    *  @param element Element to remove
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self.copy()

        removeAll(keepCapacity: true)

        anotherSelf.each {
            (index: Int, current: Element) in
            if current as U != element {
                self.append(current)
            }
        }
    }

    /**
    *  Constructs an array containing the integers in the given range
    *  @param range
    *  @return Array of integers
    */
    static func range <U: ForwardIndex> (range: Range<U>) -> Array<U> {
        return Array<U>(range)
    }

    /**
    *  Returns a subarray in the given range
    *  @return Subarray or nil if the index is out of bounds
    */
    subscript (var range: Range<Int>) -> Array {
        //  Fix out of bounds indexes
        (range.startIndex, range.endIndex) = (range.startIndex.clamp(0, max: range.startIndex), range.endIndex.clamp(range.endIndex, max: count))

        if range.startIndex > range.endIndex {
            return []
        }

        return Array(self[range] as Slice<T>)
    }

    /**
    *  Same as `at`
    *  @param first First index
    *  @param second Second index
    *  @param rest Rest of indexes
    *  @return Array with the items at the specified indexes
    *  @note It's a 2 + n params function to prevent conflicts with
    *  the default array subscript function
    */
    subscript (first: Int, second: Int, rest: Int...) -> Array {
        return at(reinterpretCast([first, second] + rest))
    }

}

/**
*  Remove and element from the array
*/
@infix func - <T: Equatable> (first: Array<T>, second: T) -> Array<T> {
    return first - [second]
}

/**
*  Shorthand for the difference
*/
@infix func - <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.difference(second)
}

/**
*  Shorthand for the intersection
*/
@infix func & <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.intersection(second)
}

/**
*  Shorthand for the union
*/
@infix func | <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T> {
    return first.union(second)
}
/**
*  Array duplication
*  @param array Array to duplicate
*  @param n How many times the array must be repeated
*  @return Array of repeated values 
*/
@infix func * <ItemType> (array: ItemType[], n: Int) -> ItemType[] {
    var result = ItemType[]()

    n.times {
        result += array
    }

    return result
}

/**
*  Array items concatenation à la Ruby
*  @param array Array of Strings to join
*  @param separator Separator to join the array elements
*  @return Joined string
*/
@infix func * (array: String[], separator: String) -> String {
    return array.implode(separator)!
}
