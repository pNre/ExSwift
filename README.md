# ExSwift

JavaScript inspired (lo-dash, underscore) set of Swift extensions for standard types, functions and classes.

### Array ###

##### Instance Methods #####

Name | Signature
---- | ---------
**`first`**|`first () -> T?`
**`last`**|`last () -> T?`
**`get`**|`get (index: Int) -> T?`
**`contains`**|`contains <T: Equatable> (item: T) -> Bool`
**`difference`**|`difference <T: Equatable> (values: Array<T>...) -> Array<T>`
**`intersection`**|`func intersection <U: Equatable> (values: Array<U>...) -> Array<T>`
**`indexOf`**|`func indexOf <T: Equatable> (item: T) -> Int`
**`zip`**|`zip (arrays: Array<Any>...) -> Array<Array<Any?>>`
**`shuffle`**|`shuffle ()`
**`shuffled`**|`shuffled () -> Array<T>`
**`sample`**|`sample (size n: Int = 1) -> Array<T>`
**`max`**|`max <T: Comparable> () -> T`
**`min`**|`min <T: Comparable> () -> T`
**`each`**|`each (call: (T) -> ())`

##### Class Methods #####

Name | Signatures | Example
---- | ---------- | -------
**`range`**|`range (range: Range<Int>) -> Array<Int>`|`Array<Int>.range(0...2) == [0, 1, 2]`

##### Operators #####
Name | Signature|Function
---- | ---------|--------
\- (minus)|`<T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Difference
\[x..y]|`subscript(range: Range<Int>) -> Array<T>`|Returns the sub-array from index *x* to index *y*

### Int ###
##### Instance Methods #####

Name | Signatures
---- | ---------
**`times`**|`times (call: (Int) -> Any)`<br>`times (call: () -> Any)`<br>`times (call: () -> ())`
**`sleep`**|`sleep ()`
**`isEven`**|`isEven () -> Bool`
**`isOdd`**|`idOdd () -> Bool`

##### Class Methods #####

Name | Signatures
---- | ---------
**`random`**|`random(min: Int = 0, max: Int) -> Int`

### String ###
##### Instance Methods #####

Name | Signature
---- | ---------
**`length`**|`length () -> Int`

##### Operators #####
Name | Signature|Function
---- | ---------|--------
\[x]|`subscript(index: Int) -> String?`|Returns the substring at index *x*
\[x..y]|`subscript(range: Range<Int>) -> String`|Returns the substring from index *x* to index *y*

### To Do ###
* Compile as library as soon as XCode 6 stops crashing.
* Benchmark
* ...
