# ExSwift

JavaScript (Lo-Dash, Underscore) & Ruby inspired set of Swift extensions for standard types and classes.

## Contents ##

- [ExSwift extensions](#extensions)
	- [Array](#array)
    	- [Instance Methods](#instance-methods)
		- [Class Methods](#class-methods)
		- [Operators](#operators)
    - [Int](#int)
    	- [Instance Methods](#instance-methods-1)
    	- [Class Methods](#class-methods-1)
    - [Float](#float)
    	- [Instance Methods](#instance-methods-2)
    	- [Class Methods](#class-methods-2)
    - [String](#string)
    	- [Properties](#properties)
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

- [Utilities](#utilities)
	- [Class Methods](#class-methods-5)

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
**`tail`**|`tail (n: Int) -> Array`
**`skip`**|`skip (n: Int) -> Array`
**`skipWhile`**|`skipWhile (condition: (Element) -> Bool) -> Array`
**`contains`**|`contains <T: Equatable> (item: T...) -> Bool`
**`difference`**|`difference <T: Equatable> (values: Array<T>...) -> Array<T>`
**`intersection`**|`intersection <U: Equatable> (values: Array<U>...) -> Array`
**`union`**|`union <U: Equatable> (values: Array<U>...) -> Array`
**`unique`**|`unique <T: Equatable> () -> Array<T>`
**`indexOf`**|`indexOf <T: Equatable> (item: T) -> Int?`
**`lastIndexOf`**|`lastIndexOf <T: Equatable> (item: T) -> Int?`
**`zip`**|`zip (arrays: Array<Any>...) -> Array<Array<Any?>>`
**`partition`**|`partition (var n: Int, var step: Int? = nil) -> Array<Array<Element>>`<br>`partition (var n: Int, var step: Int? = nil, pad: Element[]?) -> Array<Array<Element>>`
**`partitionAll`**|`partitionAll (var n: Int, var step: Int? = nil) -> Array<Array<Element>>`
**`partitionBy`**|`partitionBy <T: Equatable> (cond: (Element) -> T) -> Array<Array<Element>>`
**`shuffle`**|`shuffle ()`
**`shuffled`**|`shuffled () -> Array`
**`sample`** *(random)*|`sample (size n: Int = 1) -> Array<T>`
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
**`groupBy`**|`groupBy <U> (groupingFunction group: (Element) -> (U)) -> Dictionary<U, Array>`
**`countBy`**|`countBy <U> (groupingFunction group: (Element) -> (U)) -> Dictionary<U, Int>`
**`reduceRight`**|`reduceRight <U>(initial: U, combine: (U, Element) -> U) -> U`
**`implode`**|`implode <C: ExtensibleCollection> (separator: C) -> C?`
**`flatten`**|`flatten <OutType> () -> OutType[]`
**`toDictionary`**|`toDictionary <U> (keySelector:(Element) -> U) -> Dictionary<U, Element>`

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
`* Int`|`* <ItemType> (array: ItemType[], n: Int) -> ItemType[]`|Returns a new array built by concatenating int copies of self
`* String`|`* (array: String[], separator: String) -> String`|Equivalent to `array.implode(String)`
`[x..y]`<br>`[x...y]`|`subscript(range: Range<Int>) -> Array`|Returns the sub-array from index *x* to index *y*
`[x, y, ...]`|`subscript(first: Int, second: Int, rest: Int...) -> Array`|Returns the items at *x*, *y*

## Int ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Int)

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
**`digits`**|`digits () -> (integerPart: Int[], fractionalPart: Int[])`

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

#### Instance Methods ####

Name | Signature
---- | ---------
**`explode`**|`explode (separator: Character) -> String[]`
**`at`**|`at (indexes: Int...) -> String[]`
**`matches`**|`matches (pattern: String, ignoreCase: Bool = false) -> NSTextCheckingResult[]?`
**`capitalized`**|`capitalized () -> String`
**`insert`**|`insert (index: Int, _ string: String) -> String`
**`ltrimmed`**|`ltrimmed () -> String`
**`rtrimmed`**|`rtrimmed () -> String`
**`trimmed`**|`trimmed () -> String`

#### Class Methods ####

Name | Signature
---- | ---------
**`random`**|`func random (var length len: Int = 0, charset: String = "...") -> String`

#### Operators ####
Name | Signature
---- | ---------
`[x]`|`subscript(index: Int) -> String?`
`[x..y]`<br>`[x...y]`|`subscript(range: Range<Int>) -> String`
`[x, y, z]`|`subscript (indexes: Int...) -> String[]`
`S * n`|`* (first: String, second: Int) -> String`
`=~`|`=~ (string: String, pattern: String) -> Bool`<br>`=~ (string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool`<br>`=~ (strings: String[], pattern: String) -> Bool`<br>`=~ (strings: String[], options: (pattern: String, ignoreCase: Bool)) -> Bool`
<code>&#124;~</code>|<code>&#124;~ (string: String, pattern: String) -> Bool</code><br><code>&#124;~ (string: String, options: (pattern: String, ignoreCase: Bool)) -> Bool</code>

## Range ##

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/Range)

#### Instance Methods ####

Name | Signatures
---- | ----------
**`times`**|`times (call: (T) -> ())`<br>`times (call: () -> ())`
**`each`**|`each (call: (T) -> ())`

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
**`difference`**|`difference <V: Equatable> (dictionaries: Dictionary<KeyType, V>...) -> Dictionary<KeyType, V>`
**`union`**|`union (dictionaries: Dictionary<KeyType, ValueType>...) -> Dictionary<KeyType, ValueType>`
**`intersection`**|`intersection <K, V where K: Equatable, V: Equatable> (dictionaries: Dictionary<K, V>...) -> Dictionary<K, V>`
**`has`**|`has (key: KeyType) -> Bool`
**`isEmpty`**|`isEmpty () -> Bool`
**`map`**|`map <K, V> (mapFunction map: (KeyType, ValueType) -> (K, V)) -> Dictionary<K, V>`
**`mapValues`**|`mapValues <V> (mapFunction map: (KeyType, ValueType) -> (V)) -> Dictionary<KeyType, V>`
**`each`**|`each(eachFunction each: (KeyType, ValueType) -> ())`
**`filter`**|`filter(testFunction test: (KeyType, ValueType) -> Bool) -> Dictionary<KeyType, ValueType>`
**`merge`**|`merge (dictionaries: Dictionary<KeyType, ValueType>...) -> Dictionary<KeyType, ValueType>`
**`shift`**|`shift () -> (KeyType, ValueType)`
**`groupBy`**|`groupBy <T> (groupingFunction group: (KeyType, ValueType) -> (T)) -> Dictionary<T, Array<ValueType>>`
**`countBy`**|`countBy <T> (groupingFunction group: (KeyType, ValueType) -> (T)) -> Dictionary<T, Int>`
**`any`**|`any (test: (KeyType, ValueType) -> (Bool)) -> Bool`
**`all`**|`all (test: (KeyType, ValueType) -> (Bool)) -> Bool`
**`reduce`**|`reduce <U> (initial: U, combine: (U, Element) -> U) -> U`
**`pick`, `at`**|`pick (keys: KeyType[]) -> Dictionary`<br>`pick (keys: KeyType...) -> Dictionary`<br>`at (keys: KeyType...) -> Dictionary`

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
**`cast`**|`cast <OutType> () -> OutType[]`
**`flatten`**|`flatten <OutType> () -> OutType[]`

# Utilities #

Examples in the [Wiki](https://github.com/pNre/ExSwift/wiki/ExSwift)

#### Class Methods ####

Name | Signatures
---- | ----------
**`after`**|`after <P, T> (n: Int, function: P -> T) -> (P -> T?)`<br>`func after <T> (n: Int, function: () -> T) -> (() -> T?)`
**`once`**|`once <P, T> (function: P -> T) -> (P -> T?)`<br>`once <T> (call: Void -> T) -> (Void -> T?)`
**`partial`**|`partial <P, T> (function: (P...) -> T, _ parameters: P...) -> ((P...) -> T?)`
**`bind`**|`bind <P, T> (function: (P...) -> T, _ parameters: P...) -> (() -> T)`
**`cached`**|`cached <P, R> (function: (P...) -> R) -> ((P...) -> R)`<br>`cached <P, R> (function: (P...) -> R, hash: ((P...) -> P)) -> ((P...) -> R)`

# To Do #
* ~~Wiki~~
* ~~Xcode project for both iOS & OS X~~
* Review code comments
* Example project
* Installation instructions
* Benchmark
* ...
