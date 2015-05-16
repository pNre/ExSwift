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
                    intersection.append(item as! Element)
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
                    result.append(value as! Element)
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
    First occurrence of item, if found.
    
    :param: item The item to search for
    :returns: Matched item or nil
    */
    func find <U: Equatable> (item: U) -> T? {
        if let index = indexOf(item) {
            return self[index]
        }
        
        return nil
    }
    
    /**
    First item that meets the condition.
    
    :param: condition A function which returns a boolean if an element satisfies a given condition or not.
    :returns: First matched item or nil
    */
    func find (condition: Element -> Bool) -> Element? {
        return takeFirst(condition)
    }

    /**
        Index of the first occurrence of item, if found.
    
        :param: item The item to search for
        :returns: Index of the matched item or nil
    */
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return Swift.find(unsafeBitCast(self, [U].self), item)
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
                if value as! U == item {
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

        return index >= 0 && index < count ? self[index] : nil
        
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
    func zip (arrays: Any...) -> [[Any?]] {

        var result = [[Any?]]()

        //  Gets the longest sequence
        let max = arrays.map { (element: Any) -> Int in
            return reflect(element).count
        }.max() as Int

        for i in 0..<max {

            //  i-th element in self as array + every i-th element in each array in arrays
            result.append([get(i)] + arrays.map { (element) -> Any? in
                let (_, mirror) = reflect(element)[i]
                return mirror.value
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
            
            result += [self[i..<end]]
            
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
            result += [self[i..<(i + n)]]
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

            if value == lastValue {
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
            return $0 as! U
        })

    }

    /**
        Min value in the current array (if Array.Element implements the Comparable protocol).
    
        :returns: Min value
    */
    func min <U: Comparable> () -> U {

        return minElement(map {
            return $0 as! U
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
            var minElement: T = firstValue
            var minValue: U = call(firstValue)
            for i in 1..<self.count {
                let element: Element = self[i]
                let value: U = call(element)
                if value < minValue {
                    minElement = element
                    minValue = value
                }
            }
            return minElement
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
    @availability(*, unavailable, message="use 'reverse().each' instead") func eachRight (call: (Element) -> ()) {
        reverse().each(call)
    }

    /**
        Iterates on each element of the array, with its index, from Right to Left.
    
        :param: call Function to call for each element
    */
    @availability(*, unavailable, message="use 'reverse().each' instead") func eachRight (call: (Int, Element) -> ()) {
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

        return  self[(count - n)..<count]
        
    }

    /**
        Subarray from n to the end of the array.
    
        :param: n Number of elements to skip
        :returns: Array from n to the end
    */
    func skip (n: Int) -> Array {
    
        return n > count ? [] : self[Int(n)..<count]
        
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
            if !result.contains(item as! T) {
                result.append(item as! T)
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
        Returns all permutations of a given length within an array
        
        :param: length The length of each permutation
        :returns: All permutations of a given length within an array
    */
    func permutation (length: Int) -> [[T]] {
        var selfCopy = self
        if length < 0 || length > self.count {
            return []
        } else if length == 0 {
            return [[]]
        } else {
            var permutations: [[T]] = []
            let combinations = combination(length)
            for combination in combinations {
                var endArray: [[T]] = []
                var mutableCombination = combination
                permutations += self.permutationHelper(length, array: &mutableCombination, endArray: &endArray)
            }
            return permutations
        }
    }

    /**
        Recursive helper method where all of the permutation-generating work is done
        This is Heap's algorithm
    */
    private func permutationHelper(n: Int, inout array: [T], inout endArray: [[T]]) -> [[T]] {
        if n == 1 {
            endArray += [array]
        }
        for var i = 0; i < n; i++ {
            permutationHelper(n - 1, array: &array, endArray: &endArray)
            var j = n % 2 == 0 ? i : 0;
            //(array[j], array[n - 1]) = (array[n - 1], array[j])
            var temp: T = array[j]
            array[j] = array[n - 1]
            array[n - 1] = temp
        }
        return endArray
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
        Returns all of the combinations in the array of the given length, allowing repeats
        
        :param: length
        :returns: Combinations
    */
    func repeatedCombination (length: Int) -> [[Element]] {
        if length < 0 {
            return []
        }
        var indexes: [Int] = []
        length.times {
            indexes.append(0)
        }
        var combinations: [[Element]] = []
        var offset = self.count - indexes.count
        while true {
            var combination: [Element] = []
            for index in indexes {
                combination.append(self[index])
            }
            combinations.append(combination)
            var i = indexes.count - 1
            while i >= 0 && indexes[i] == self.count - 1 {
                i--
            }
            if i < 0 {
                break
            }
            indexes[i]++
            (i+1).upTo(indexes.count - 1) { j in
                indexes[j] = indexes[i]
            }
        }
        return combinations
    }

    /**
        Returns all of the combinations in the array of the given length
        
        :param: length
        :returns: Combinations
    */
    func combination (length: Int) -> [[Element]] {
        if length < 0 || length > self.count {
            return []
        }
        var indexes: [Int] = (0..<length).toArray()
        var combinations: [[Element]] = []
        var offset = self.count - indexes.count
        while true {
            var combination: [Element] = []
            for index in indexes {
                combination.append(self[index])
            }
            combinations.append(combination)
            var i = indexes.count - 1
            while i >= 0 && indexes[i] == i + offset {
                i--
            }
            if i < 0 {
                break
            }
            i++
            var start = indexes[i-1] + 1
            for j in (i-1)..<indexes.count {
                indexes[j] = start + j - i + 1
            }
        }
        return combinations
    }

    /**
        Returns all of the permutations of this array of a given length, allowing repeats
        
        :param: length The length of each permutations
        :returns All of the permutations of this array of a given length, allowing repeats
    */
    func repeatedPermutation(length: Int) -> [[T]] {
        if length < 1 {
            return []
        }
        var permutationIndexes: [[Int]] = []
        permutationIndexes.repeatedPermutationHelper([], length: length, arrayLength: self.count, permutationIndexes: &permutationIndexes)
        return permutationIndexes.map({ $0.map({ i in self[i] }) })
    }

    private func repeatedPermutationHelper(seed: [Int], length: Int, arrayLength: Int, inout permutationIndexes: [[Int]]) {
        if seed.count == length {
            permutationIndexes.append(seed)
            return
        }
        for i in (0..<arrayLength) {
            var newSeed: [Int] = seed
            newSeed.append(i)
            self.repeatedPermutationHelper(newSeed, length: length, arrayLength: arrayLength, permutationIndexes: &permutationIndexes)
        }
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

    func eachIndex (call: (Int) -> ()) -> () {
        (0..<self.count).each({ call($0) })
    }

    /**
        Returns a transposed version of the array, where the object at array[i][j] goes to array[j][i].
        The array must have two or more dimensions.
        If it's a jagged array that has empty spaces between elements in the transposition, those empty spaces are "removed" and the element on the right side of the empty space gets squashed next to the element on the left.

        :return: A transposed version of the array, where the object at array[i][j] goes to array[j][i]
    */
    func transposition (array: [[T]]) -> [[T]] { //<U: AnyObject where Element == [U]> () -> [[U]] {
        var maxWidth: Int = array.map({ $0.count }).max()
        var transposition = [[T]](count: maxWidth, repeatedValue: [])
        
        (0..<maxWidth).each { i in
            array.eachIndex { j in
                if array[j].count > i {
                    transposition[i].append(array[j][i])
                }
            }
        }
        return transposition
    }

    /**
        Replaces each element in the array with object. I.e., it keeps the length the same but makes the element at every index be object
        
        :param: object The object to replace each element with
    */
    mutating func fill (object: T) -> () {
        (0..<self.count).each { i in
            self[i] = object
        }
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
        Creates an array with values and an accumulated result by running accumulated result
        and each value of self through the mapFunction.
    
        :param: initial Initial value for accumulator
        :param: mapFunction
        :returns: Accumulated value and mapped array
    */
    func mapAccum <U, V> (initial: U, mapFunction map: (U, Element) -> (U, V)) -> (U, [V]) {
        var mapped = [V]()
        var acc = initial
        
        each { (value: Element) -> Void in
            let (mappedAcc, mappedValue) = map(acc, value)
            acc = mappedAcc
            mapped.append(mappedValue)
        }
        
        return (acc, mapped)
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
    @availability(*, unavailable, message="use 'reverse().reduce' instead") func reduceRight <U> (initial: U, combine: (U, Element) -> U) -> U {
        return reverse().reduce(initial, combine: combine)
    }

    /**
        self.reduceRight with initial value self.last()
    */
    @availability(*, unavailable, message="use 'reverse().reduce' instead") func reduceRight (combine: (Element, Element) -> Element) -> Element? {
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
        Converts the array to a dictionary with keys and values supplied via the transform function.
    
        :param: transform
        :returns: A dictionary
    */
    func toDictionary <K, V> (transform: (Element) -> (key: K, value: V)?) -> [K: V] {
        var result: [K: V] = [:]
        for item in self {
            if let entry = transform(item) {
                result[entry.key] = entry.value
            }
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
    @availability(*, unavailable, message="use 'sorted' instead") func sortBy (isOrderedBefore: (T, T) -> Bool) -> [T] {
        return sorted(isOrderedBefore)
    }

    /**
        Calls the passed block for each element in the array, either n times or infinitely, if n isn't specified

        :param: n the number of times to cycle through
        :param: block the block to run for each element in each cycle
    */
    func cycle (n: Int? = nil, block: (T) -> ()) {
        var cyclesRun = 0
        while true {
            if let n = n {
                if cyclesRun >= n {
                    break
                }
            }
            for item in self {
                block(item)
            }
            cyclesRun++
        }
    }

    /**
        Runs a binary search to find the smallest element for which the block evaluates to true
        The block should return true for all items in the array above a certain point and false for all items below a certain point
        If that point is beyond the furthest item in the array, it returns nil

        See http://ruby-doc.org/core-2.2.0/Array.html#method-i-bsearch regarding find-minimum mode for more

        :param: block the block to run each time
        :returns: the min element, or nil if there are no items for which the block returns true
    */
    func bSearch (block: (T) -> (Bool)) -> T? {
        if count == 0 {
            return nil
        }

        var low = 0
        var high = count - 1
        while low <= high {
            var mid = low + (high - low) / 2
            if block(self[mid]) {
                if mid == 0 || !block(self[mid - 1]) {
                    return self[mid]
                } else {
                    high = mid
                }
            } else {
                low = mid + 1
            }
        }

        return nil
    }

    /**
        Runs a binary search to find some element for which the block returns 0.
        The block should return a negative number if the current value is before the target in the array, 0 if it's the target, and a positive number if it's after the target
        The Spaceship operator is a perfect fit for this operation, e.g. if you want to find the object with a specific date and name property, you could keep the array sorted by date first, then name, and use this call:
        let match = bSearch {  [targetDate, targetName] <=> [$0.date, $0.name] }

        See http://ruby-doc.org/core-2.2.0/Array.html#method-i-bsearch regarding find-any mode for more
    
        :param: block the block to run each time
        :returns: an item (there could be multiple matches) for which the block returns true
    */
    func bSearch (block: (T) -> (Int)) -> T? {
        let match = bSearch { item in
            block(item) >= 0
        }
        if let match = match {
            return block(match) == 0 ? match : nil
        } else {
            return nil
        }
    }

    /**
        Sorts the array by the value returned from the block, in ascending order

        :param: block the block to use to sort by
        :returns: an array sorted by that block, in ascending order
    */
    func sortUsing <U:Comparable> (block: ((T) -> U)) -> [T] {
        return self.sorted({ block($0.0) < block($0.1) })
    }

    /**
        Removes the last element from self and returns it.

        :returns: The removed element
    */
    mutating func pop () -> Element? {
        
        if self.isEmpty {
            return nil
        }
    
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
    mutating func shift () -> Element? {
        
        if self.isEmpty {
            return nil
        }
        
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
            if (current as! U) != element {
                self.append(current)
            }
        }
    }

    /**
        Constructs an array containing the values in the given range.
    
        :param: range
        :returns: Array of values
    */
    @availability(*, unavailable, message="use the '[U](range)' constructor") static func range <U: ForwardIndexType> (range: Range<U>) -> [U] {
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
            
        return Array(self[Range(start: start, end: end)] as ArraySlice<T>)
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
public func - <T: Equatable> (first: [T], second: T) -> [T] {
    return first - [second]
}

/**
    Difference operator
*/
public func - <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.difference(second)
}

/**
    Intersection operator
*/
public func & <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.intersection(second)
}

/**
    Union operator
*/
public func | <T: Equatable> (first: [T], second: [T]) -> [T] {
    return first.union(second)
}
/**
    Array duplication.

    :param: array Array to duplicate
    :param: n How many times the array must be repeated
    :returns: Array of repeated values
*/
public func * <ItemType> (array: [ItemType], n: Int) -> [ItemType] {

    var result = [ItemType]()

    (0..<n).times {
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
public func * (array: [String], separator: String) -> String {
    return array.implode(separator)!
}
