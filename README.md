# ExSwift
![CocoaPods](https://img.shields.io/cocoapods/v/ExSwift.svg) [![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage) [![Build Status](https://travis-ci.org/pNre/ExSwift.svg)](https://travis-ci.org/pNre/ExSwift)

Set of Swift extensions for standard types and classes.

# Installation

Because of Xcode errors it's not possible to integrate this project with Cocoapods or as Embedded Framework.
[Read more at Dev Forum](https://devforums.apple.com/message/983747#983747)

## Use submodule and copy source code
1. Add ExSwift as a submodule
2. Open the `ExSwift` project folder, and drag `ExSwift` sub folder with source code into the file navigator of your Xcode project. Make sure you select add to target
3. Use it

``` swift
components.takeFirst() { $0.completed }
```

## Contents ##

- [ExSwift extensions](#extensions)
	- [Array](#array)
    	- [Instance Methods](#instance-methods)
		- [Class Methods](#class-methods)
		- [Operators](#operators)
    - [Int](#int)
       - [Properties](#properties)
    	- [Instance Methods](#instance-methods-1)
    	- [Class Methods](#class-methods-1)
    - [Float](#float)
    	- [Instance Methods](#instance-methods-2)
    	- [Class Methods](#class-methods-2)
    - [String](#string)
    	- [Properties](#properties-1)
    	- [Instance Methods](#instance-methods-3)
		- [Class Methods](#class-methods-3)
		- [Operators](#operators-1)
    - [Range](#range)
    	- [Instance Methods](#instance-methods-4)
    	- [Class Methods](#class-methods-4)
    	- [Operators](#operators-2)
    - [Dictionary](#dictionary)
    	- [Instance Methods](#instance-methods-5)
    	- [Operators](#operators-3)
    - [NSArray](#nsarray)
    	- [Instance Methods](#instance-methods-6)
   	- [SequenceOf](#sequenceof)
    	- [Instance Methods](#instance-methods-7)
	- [Double](#double)
		- [Instance Methods](#instance-methods-8)
		- [Class Methods](#class-methods-5)
	- [NSDate](#nsdate)
		- [Instance Methods](#instance-methods-9)
		- [Operators](#operators-4)
	- [UIColor](#uicolor)
		- [Init Methods](#init-methods)

- [Utilities](#utilities)
	- [Class Methods](#class-methods-6)
	- [Operators](#operators-5)

# Extensions #

## Array ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Array)

#### Instance Methods ####

Name | Signature
---- | ---------
**`first`**|`first () -> Element?`
**`last`**|`last () -> Element?`
**`get`**|`get (index: Int) -> Element?`
**`remove`**|`remove <U: Equatable> (element: U)`
**`at`**|`at (indexes: Int...) -> Array`
**`take`**|`take (n: Int) -> Array`
**`takeWhile`**|`takeWhile (condition: (Element) -> Bool) -> Array`
**`takeFirst`**|`takeFirst (condition: (Element) -> Bool) -> Element?`
**`tail`**|`tail (n: Int) -> Array`
**`skip`**|`skip (n: Int) -> Array`
**`skipWhile`**|`skipWhile (condition: (Element) -> Bool) -> Array`
**`contains`**|`contains <T: Equatable> (item: T...) -> Bool`
**`difference`**|`difference <T: Equatable> (values: [T]...) -> [T]`
**`intersection`**|`intersection <U: Equatable> (values: [U]...) -> Array`
**`union`**|`union <U: Equatable> (values: [U]...) -> Array`
**`unique`**|`unique <T: Equatable> () -> [T]`
**`indexOf`**|`indexOf <T: Equatable> (item: T) -> Int?`
**`indexOf`**|`indexOf (condition: Element -> Bool) -> Int?`
**`lastIndexOf`**|`lastIndexOf <T: Equatable> (item: T) -> Int?`
**`zip`**|`zip (arrays: Array<Any>...) -> [[Any?]]`
**`partition`**|`partition (var n: Int, var step: Int? = nil) -> [Array]`<br>`partition (var n: Int, var step: Int? = nil, pad: Element[]?) -> [Array]`
**`partitionAll`**|`partitionAll (var n: Int, var step: Int? = nil) -> [Array]`
**`partitionBy`**|`partitionBy <T: Equatable> (cond: (Element) -> T) -> [Array]`
**`shuffle`**|`shuffle ()`
**`shuffled`**|`shuffled () -> Array`
**`sample`** *(random)*|`sample (size n: Int = 1) -> [T]`
**`max`**|`max <T: Comparable> () -> T`
**`min`**|`min <T: Comparable> () -> T`
**`each`**|`each (call: (Element) -> ())`<br>`each (call: (Int, Element) -> ())`
**`eachRight`**|`eachRight (call: (Element) -> ())`<br>`eachRight (call: (Int, Element) -> ())`
**`any`**|`any (call: (Element) -> Bool) -> Bool`
**`all`**|`all (call: (Element) -> Bool) -> Bool`
**`reject`**|`reject (exclude: (Element -> Bool)) -> Array`
**`pop`**|`pop() -> Element`
**`push`**|`push(newElement: Element)`
**`shift`**|`shift() -> Element`
**`unshift`**|`unshift(newElement: Element)`
**`insert`**|`insert (newArray: Array, atIndex: Int)`
**`groupBy`**|`groupBy <U> (groupingFunction group: (Element) -> (U)) -> [U: Array]`
**`countBy`**|`countBy <U> (groupingFunction group: (Element) -> (U)) -> [U: Int]`
**`countWhere`**|`countWhere (test: (Element) -> Bool) -> Int`
**`reduce`**|`reduce (combine: (Element, Element) -> Element) -> Element?`
**`reduceRight`**|`reduceRight <U>(initial: U, combine: (U, Element) -> U) -> U`
**`mapFilter`**|`mapFilter <V> (mapFunction map: (Element) -> (V)?) -> [V]`
**`implode`**|`implode <C: ExtensibleCollection> (separator: C) -> C?`
**`flatten`**|`flatten <OutType> () -> [OutType]`
**`flattenAny`**|`flattenAny () -> [AnyObject]`
**`toDictionary`**|`toDictionary <U> (keySelector:(Element) -> U) -> [U: Element]`
**`toDictionary`**|`toDictionary <K, V> (transform: (Element) -> (key: K, value: V)?) -> [K: V]`
**`cycle`**|`cycle (n: Int? = nil, block: (T) -> ())`
**`bSearch`**|`bSearch (block: (T) -> (Bool)) -> T?`
**`bSearch`**|`bSearch (block: (T) -> (Int)) -> T?`
**`sortUsing`**|`sortUsing<U:Comparable>(block: ((T) -> U)) -> [T]`
**`transposition`**|`transposition (array: [[T]]) -> [[T]]`
**`permutation`**|`permutation (length: Int) -> [[T]]`
**`repeatedPermutation`**|`repeatedPermutation(length: Int) -> [[T]]`
**`combination`**|`combination (length: Int) -> [[Element]]`
**`repeatedCombination `**|`repeatedCombination (length: Int) -> [[Element]]`

#### Class Methods ####

Name | Signatures
---- | ----------
**`range`**|`range <U: ForwardIndex> (range: Range<U>) -> Array<U>`

#### Operators ####
Name | Signature | Function
---- | --------- | --------
`-`|`- <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Difference
`-`|`- <T: Equatable> (first: Array<T>, second: T) -> Array<T>`|Element removal
`&`|`& <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Intersection
<code>&#124;</code>|<code>&#124; <T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T></code>|Union
`* Int`|`* <ItemType> (array: ItemType[], n: Int) -> [ItemType]`|Returns a new array built by concatenating int copies of self
`* String`|`* (array: String[], separator: String) -> String`|Equivalent to `array.implode(String)`
`[rangeAsArray: x..y]`<br>`[rangeAsArray: x...y]`|`subscript(#rangeAsArray: Range<Int>) -> Array`|Returns the sub-array from index *x* to index *y*
`[x, y, ...]`|`subscript(first: Int, second: Int, rest: Int...) -> Array`|Returns the items at *x*, *y*

## Int ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Int)

#### Properties ####
Name |
---- |
`NSTimeInterval`**`years`**|
`NSTimeInterval`**`year`**|
`NSTimeInterval`**`days`**|
`NSTimeInterval`**`day`**|
`NSTimeInterval`**`hours`**|
`NSTimeInterval`**`hour`**|
`NSTimeInterval`**`minutes`**|
`NSTimeInterval`**`minute`**|
`NSTimeInterval`**`seconds`**|
`NSTimeInterval`**`second`**|

#### Instance Methods ####

Name | Signatures
---- | ----------
**`times`**|`times <T> (call: (Int) -> T)`<br>`times <T> (call: () -> T)`<br>`times (call: () -> ())`
**`isEven`**|`isEven () -> Bool`
**`isOdd`**|`idOdd () -> Bool`
**`upTo`**|`upTo (limit: Int, call: (Int) -> ())`
**`downTo`**|`downTo (limit: Int, call: (Int) -> ())`
**`clamp`**|`clamp (range: Range<Int>) -> Int`<br>`clamp (min: Int, max: Int) -> Int`
**`isIn`**|`isIn (range: Range<Int>, strict: Bool = false) -> Bool`
**`digits`**|`digits () -> Array<Int>`
**`abs`**|`abs () -> Int`
**`gcd`**|`gcd (n: Int) -> Int`
**`lcm`**|`lcm (n: Int) -> Int`

#### Class Methods ####

Name | Signatures
---- | ----------
**`random`**|`random(min: Int = 0, max: Int) -> Int`


## Float ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Float)

#### Instance Methods ####

Name | Signature
---- | ---------
**`abs`**|`abs () -> Float`
**`sqrt`**|`sqrt () -> Float`
**`round`**|`round () -> Float`
**`ceil`**|`ceil () -> Float`
**`floor`**|`floor () -> Float`
**`clamp`**|`clamp (min: Float, _ max: Float) -> Float`

#### Class Methods ####

Name | Signatures
---- | ----------
**`random`**|`random(min: Float = 0, max: Float) -> Float`

## String ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/String)

#### Properties ####
Name |
---- |
**`length`**|
**`capitalized`**|

#### Instance Methods ####

Name | Signature
---- | ---------
**`explode`**|`explode (separator: Character) -> [String]`
**`at`**|`at (indexes: Int...) -> [String]`
**`matches`**|`matches (pattern: String, ignoreCase: Bool = false) -> [NSTextCheckingResult]?`
**`insert`**|`insert (index: Int, _ string: String) -> String`
**`ltrimmed`**|`ltrimmed () -> String`
**`ltrimmed`**|`ltrimmed (set: NSCharacterSet) -> String`
**`rtrimmed`**|`rtrimmed () -> String`
**`rtrimmed`**|`rtrimmed (set: NSCharacterSet) -> String`
**`trimmed`**|`trimmed () -> String`
**`rtrimmed`**|`rtrimmed (set: NSCharacterSet) -> String`
**`toDouble`**|`toDouble() -> Double?`
**`toFloat`**|`toFloat() -> Float?`
**`toUInt`**|`toUInt() -> UInt?`
**`toBool`**|`toBool() -> Bool?`
**`toDate`**|`toDate(format : String? = "yyyy-MM-dd") -> NSDate?`
**`toDateTime`**|`toDateTime(format : String? = "yyyy-MM-dd hh-mm-ss") -> NSDate?`


#### Class Methods ####

Name | Signature
---- | ---------
**`random`**|`func random (var length len: Int = 0, charset: String = "...") -> String`

#### Operators ####
Name | Signature
---- | ---------
`[x]`|`subscript(index: Int) -> String?`
`[x..y]`<br>`[x...y]`|`subscript(range: Range<Int>) -> String`
`[x, y, z]`|`subscript (indexes: Int...) -> [String]`
`S * n`|`* (first: String, second: Int) -> String`
`=~`|`=~ (string: String, pattern: String) -> Bool`<br>`=~ (string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool`<br>`=~ (strings: [String], pattern: String) -> Bool`<br>`=~ (strings: [String], options: (pattern: String, ignoreCase: Bool)) -> Bool`
<code>&#124;~</code>|<code>&#124;~ (string: String, pattern: String) -> Bool</code><br><code>&#124;~ (string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool</code>

## Range ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Range)

#### Instance Methods ####

Name | Signatures
---- | ----------
**`times`**|`times (call: (T) -> ())`<br>`times (call: () -> ())`
**`each`**|`each (call: (T) -> ())`
**`toArray`**|`toArray () -> [T]`

#### Class Methods ####

Name | Signature
---- | ---------
**`random`**|`random (from: Int, to: Int) -> Range<Int>`

#### Operators ####
Name | Signature|Function
---- | ---------|--------
`=`|`== <U: ForwardIndex> (first: Range<U>, second: Range<U>) -> Bool`|Compares 2 ranges

## Dictionary ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Dictionary)

#### Instance Methods ####

Name | Signatures
---- | ----------
**`difference`**|`difference <V: Equatable> (dictionaries: [Key: V]...) -> [Key: V]`
**`union`**|`union (dictionaries: [Key: Value]...) -> [Key: Value]`
**`intersection`**|`intersection <K, V where K: Equatable, V: Equatable> (dictionaries: [K: V]...) -> [K: V]`
**`has`**|`has (key: Key) -> Bool`
**`map`**|`map <K, V> (mapFunction map: (Key, Value) -> (K, V)) -> [K: V]`
**`mapFilter`**|`mapFilter <K, V> (mapFunction map: (Key, Value) -> (K, V)?) -> [K: V]`
**`mapValues`**|`mapValues <V> (mapFunction map: (Key, Value) -> (V)) -> [Key: V]`
**`mapFilterValues`**|`mapFilterValues <V> (mapFunction map: (Key, Value) -> V?) -> [Key: V]`
**`each`**|`each(eachFunction each: (Key, Value) -> ())`
**`filter`**|`filter(testFunction test: (Key, Value) -> Bool) -> [Key: Value]`
**`merge`**|`merge (dictionaries: [Key: Value]...) -> [Key: Value]`
**`shift`**|`shift () -> (Key, Value)`
**`groupBy`**|`groupBy <T> (groupingFunction group: (Key, Value) -> (T)) -> [T: Array<Value>]`
**`countBy`**|`countBy <T> (groupingFunction group: (Key, Value) -> (T)) -> [T: Int]`
**`countWhere`**|`countWhere (test: (Key, Value) -> (Bool)) -> Int`
**`any`**|`any (test: (Key, Value) -> (Bool)) -> Bool`
**`all`**|`all (test: (Key, Value) -> (Bool)) -> Bool`
**`reduce`**|`reduce <U> (initial: U, combine: (U, Element) -> U) -> U`
**`pick`, `at`**|`pick (keys: [Key]) -> Dictionary`<br>`pick (keys: Key...) -> Dictionary`<br>`at (keys: Key...) -> Dictionary`
**`toArray`**|`toArray <V> (mapFunction map: (Key, Value) -> V) -> [V]`

#### Operators ####
Name | Signature | Function
---- | --------- | --------
`-`|`- <K, V: Equatable> (first: Dictionary<K, V>, second: Dictionary<K, V>) -> Dictionary<K, V>`|Difference
`&`|`& <K, V: Equatable> (first: Dictionary<K, V>, second: Dictionary<K, V>) -> Dictionary<K, V>`|Intersection
<code>&#124;</code>|<code>&#124; <K, V: Equatable> (first: Dictionary<K, V>, second: Dictionary<K, V>) -> Dictionary<K, V></code>|Union

## NSArray ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/NSArray)

#### Instance Methods ####

Name | Signatures
---- | ----------
**`cast`**|`cast <OutType> () -> [OutType]`
**`flatten`**|`flatten <OutType> () -> [OutType]`
**`flattenAny`**|`flattenAny () -> [AnyObject]`

## SequenceOf ##

The following operations can be performed on sequences and are evaluated lazily. Each operation only takes the data it requires from the source sequence in order to return its result.

The `Sequence` protocol cannot be extended, hence the following are extensions to `SequenceOf`. They can be used as follows:

```
var source: Sequence = ...
var filteredSequence = SequenceOf(source).filter { ... }
```

#### Instance Methods ####

Name | Signatures
---- | ----------
**`first`**|`first () -> T?`
**`any`**|`any (call: (T) -> Bool) -> Bool`
**`get`**|`get (index: Int) -> T?`
**`get`**|`get (range: Range<Int>) -> SequenceOf<T>`
**`indexOf`**|`indexOf <U: Equatable> (item: U) -> Int?`
**`filter`**|`filter(include: (T) -> Bool) -> SequenceOf<T>`
**`reject`**|`reject (exclude: (T -> Bool)) -> SequenceOf<T>`
**`skipWhile`**|`skipWhile(condition:(T) -> Bool) -> SequenceOf<T>`
**`skip`**|`skip (n:Int) -> SequenceOf<T>`
**`contains`**|`contains<T:Equatable> (item: T) -> Bool`
**`take`**|`take (n:Int) -> SequenceOf<T>`
**`takeWhile`**|`takeWhile (condition:(T?) -> Bool) -> SequenceOf<T>`

## Double ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Double)

#### Instance Methods ####

Name | Signature
---- | ---------
**`abs`**|`abs () -> Double`
**`sqrt`**|`sqrt () -> Double`
**`round`**|`round () -> Double`
**`ceil`**|`ceil () -> Double`
**`floor`**|`floor () -> Double`
**`clamp`**|`clamp (min: Double, _ max: Double) -> Double`
**`roundToNearest`**|`roundToNearest(increment: Double) -> Double`

#### Class Methods ####

Name | Signatures
---- | ----------
**`random`**|`random(min: Double = 0, max: Double) -> Double`

# NSDate #

#### Properties ####
Name | Signatures
---- | ----
**`year`** |`Int`
**`month`**|`Int`
**`weekday`** |`Int`
**`weekMonth`**|`Int`
**`days`** |`Int`
**`hours`**|`Int`
**`minutes`** |`Int`
**`seconds`**| `Int`

#### Instance Methods ####
Name | Signatures
---- | ----------
**`add`**|`add(seconds:Int=0, minutes:Int = 0, hours:Int = 0, days:Int = 0, weeks:Int = 0, months:Int = 0, years:Int = 0) -> NSDate`
**`addSeconds`**|`addSeconds (seconds:Int) -> NSDate `
**`addMinutes`**|`addMinutes (minute:Int) -> NSDate `
**`addHours`**|`addHours(hours:Int) -> NSDate `
**`addDays`**|`addDays(days:Int) -> NSDate `
**`addWeeks`**|`addWeeks(weeks:Int) -> NSDate`
**`addMonths`**|`addMonths(months:Int) -> NSDate`
**`addYears`**|`addYears(years:Int) -> NSDate `
**`isAfter`**|`isAfter(date: NSDate) -> Bool`
**`isBefore`**|`isBefore(date: NSDate) -> Bool`
**`getComponent`**|`getComponent (component : NSCalendarUnit) -> Int`

#### Operators ####

Name | Signatures
---- | ----------
**`==`**|`==(lhs: NSDate, rhs: NSDate) -> Bool`
**`<`**|`<(lhs: NSDate, rhs: NSDate) -> Bool`
**`>`**|`>(lhs: NSDate, rhs: NSDate) -> Bool`
**`<=`**|`<=(lhs: NSDate, rhs: NSDate) -> Bool`
**`>=`**|`>=(lhs: NSDate, rhs: NSDate) -> Bool`
**`==`**|`==(lhs: NSDate, rhs: NSDate) -> Bool`

# UIColor #

#### Init Methods ####
Name | Signatures
---- | ----
**`hex`** |`(hex: Int)`
**`hex`** |`(hex: Int, alpha: CGFloat)`

# Utilities #

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/ExSwift)

#### Class Methods ####

Name | Signatures
---- | ----------
**`after`**|`after <P, T> (n: Int, function: P -> T) -> (P -> T?)`<br>`func after <T> (n: Int, function: () -> T) -> (() -> T?)`
**`once`**|`once <P, T> (function: P -> T) -> (P -> T?)`<br>`once <T> (call: Void -> T) -> (Void -> T?)`
**`partial`**|`partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T?)`
**`bind`**|`bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (() -> T)`
**`cached`**|`cached <P, R> (function: P -> R) -> (P -> R)`<br>`cached <P, R> (function: (P...) -> R) -> ((P...) -> R)`<br>`cached <P, R> (function: (P...) -> R, hash: ((P...) -> P)) -> ((P...) -> R)`

#### Operators ####
Name | Signatures
---- | ----------
**`<=>`**|`<=> <T: Comparable>(lhs: T, rhs: T) -> Int`

# To Do #
* [X] Wiki
* [X] Xcode project for both iOS & OS X
* [X] Review code comments
* [ ] Example project
* [ ] Installation instructions
* [ ] Benchmark
