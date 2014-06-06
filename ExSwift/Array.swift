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
    func contains <T: Equatable> (item: T) -> Bool {
        return indexOf(item) >= 0
    }

    /**
    *  Computes the difference between self and the input arrays
    *  @param values Arrays to subtract
    *  @return Difference between self and the input arrays
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
    *  Computes the intersection between self and the input arrays
    *  @param values Arrays to intersect
    *  @return Array of unique values present in all the values arrays + self
    */
    func intersection <U: Equatable> (values: Array<U>...) -> Array<T> {

        var result: Array<T> = self as Array<T>
        var intersection = Array<T>()

        for (i, value) in enumerate(values) {

            //  the intersection is computed by intersecting a couple per loop:
            //  self n values[0], (self n values[0]) n values[1], ...
            if (i > 0) {
                result = intersection
                intersection = Array<T>()
            }

            //  find common elements and save them in first set
            //  to intersect in the next loop
            for item in value {
                if result.contains(item) {
                    intersection.append(item as T)
                }
            }

        }

        return intersection

    }

    /**
    *  Computes the union between self and the input arrays
    *  @param values Arrays
    *  @return Union array of unique values
    */
    func union <U: Equatable> (values: Array<U>...) -> Array<T> {

        var result: Array<T> = self as Array<T>

        for array in values {
            for value in array {
                if !result.contains(value) {
                    result.append(value as T)
                }
            }
        }

        return result

    }

    /**
    *  Gets the first element of the array
    *  @return First element of the array
    */
    func first () -> T? {
        if count > 0 {
            return self[0]
        }
        return nil
    }

    /**
    *  Gets the last element of the array
    *  @return Last element of the array
    */
    func last () -> T? {
        if count > 0 {
            return self[count - 1]
        }
        return nil
    }
    
    /**
    *  Gets the index at which the first occurrence of item is found
    *  @param item The item to search for
    *  @return Index of the matched item or -1
    */
    func indexOf <U: Equatable> (item: U) -> Int {
        if item is T {
            if let found = find(reinterpretCast(self) as Array<U>, item) {
                return found
            }

            return -1
        }

        return -1
    }
    
    /**
    *  Gets the object at the specified index if exists
    *  @param index
    *  @return Object at index in array, nil if index is out of bounds
    */
    func get (index: Int) -> T? {
        return index < count ? self[index] : nil
    }
    
    /**
    *  Gets the objects in the specified range
    *  @param range
    *  @return Subarray in range
    */
    func get (range: Range<Int>) -> Array<T>? {
        var subarray = Array<T>()
        
        for var i = range.startIndex; i < range.endIndex; i++ {
            subarray += [self[i]]
        }
        
        return subarray
    }
    
    /**
    *  Creates an array of grouped elements, the first of which contains the first elements of the given arrays, the 2nd contains the 2nd elements of the given arrays, and so on
    *  @param arrays Arrays to zip
    *  @return Array of grouped elements
    */
    func zip (arrays: Array<Any>...) -> Array<Array<Any?>> {

        var result = Array<Array<Any?>>()

        //  Gets the longest array
        let max = arrays.reduce(count, combine: {
            (max: Int, item: Array<Any>) -> Int in
            return item.count > max ? item.count : max;
        })

        for i in 0..max {
            var item = Array<Any?>()

            item.append(get(i))

            for array in arrays {
                item.append(array.get(i))
            }

            result.append(item)

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
    *  Creates an array of shuffled values
    *  @return Shuffled copy of self
    */
    func shuffled () -> Array<T> {
        var shuffled = self.copy()

        //  Fisher-Yates shuffle
        for i in 0..self.count {
            let j = Int.random(max: i)
            if j != i {
                shuffled[i] = shuffled[j]
            }
            shuffled[j] = self[i]
        }

        return shuffled
    }

    /**
    *  Returns a random subarray of length n
    *  @param n Length
    *  @return Random subarray of length n
    */
    func sample (size n: Int = 1) -> Array<T> {
        let index = Int.random(max: count - n)
        return self[index..(n + index)]
    }

    /**
    *  Returns the max value in the current array
    *  @return Max value
    */
    func max <U: Comparable> () -> U {

        return maxElement(map {
            return $0 as U
        })

    }

    /**
    *  Returns the min value in the current array
    *  @return Min value
    */
    func min <U: Comparable> () -> U {
        
        return minElement(map {
            return $0 as U
        })

    }

    /**
    *  Iterates on self
    *  @param call Function to call for each element
    */
    func each (call: (T) -> ()) {

        for item in self {
            call(item)
        }

    }
    
    /**
    *  Iterates on self with index
    *  @param call Function to call for each element
    */
    func each (call: (Int, T) -> ()) {
        
        for (index, item) in enumerate(self) {
            call(index, item)
        }
        
    }
    
    /**
    *  Checks if call returns true for any element of self
    *  @param call Function to call for each element
    *  @return True if call returns true for any element of self
    */
    func any (call: (T) -> Bool) -> Bool {

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
    func all (call: (T) -> Bool) -> Bool {

        for item in self {

            if !call(item) {
                return false
            }

        }

        return true

    }

    /**
    *  Opposite of filter
    */
    func reject (exclude: (T -> Bool)) -> Array<T> {
        return self.filter({
            return !exclude($0)
        })
    }
    
    /**
    *  Returns first n elements from self
    *  @return First n elements
    */
    func take (n: Int) -> Array<T> {
        return self[0..n]
    }

    /**
    *  Returns a new array by removing duplicate values in self
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
    *  Creates a dictionary composed of keys generated from the results of running each element of self through groupingFunction. The corresponding value of each key is an array of the elements responsible for generating the key.
    *  @param groupingFunction
    *  @return Grouped dictionary
    */
    func groupBy <U> (groupingFunction group: (T) -> (U)) -> Dictionary<U, Array<T>> {

        var result = Dictionary<U, Array<T>>();
        
        for item in self {
            
            let groupKey = group(item)
            var array: Array<T>? = nil
            
            //  This is the first object for groupKey
            if !result.has(groupKey) {
                array = Array<T>()
            } else {
                array = result[groupKey]
            }
            
            var finalArray = array!
            
            finalArray.push(item)
            
            result[groupKey] = finalArray
            
        }
        
        return result
        
    }

    /**
    *  Removes the last element from self and returns it
    *  @return The removed element
    */
    mutating func pop () -> T {
        return self.removeLast()
    }
    
    /**
    *  Same as append
    */
    mutating func push (newElement: T) {
        return self.append(newElement)
    }
    
    /**
    *  Returns the first element of self and removes it
    *  @return The removed element
    */
    mutating func shift () -> T {
        return self.removeAtIndex(0)
    }

    /**
    *  Prepends objects to the front of self
    */
    mutating func unshift (newElement: T) {
        self.insert(newElement, atIndex: 0)
    }

    /**
    *  Deletes all the items in self that are equal to element
    *  @param element
    */
    mutating func remove <U: Equatable> (element: U) {
        let anotherSelf = self.copy()

        removeAll(keepCapacity: true)
        
        anotherSelf.each {
            (index: Int, current: T) in
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
    subscript (range: Range<Int>) -> Array<T> {
        var subarray = Array<T>()
            
        for var i = range.startIndex; i < range.endIndex; i++ {
            subarray += [self[i]]
        }
        
        return subarray
    }

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
