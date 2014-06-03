# ExSwift

JavaScript inspired (lo-dash, underscore) set of Swift extensions for standard types, functions and classes.

### Array ###

##### Methods #####

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

##### Operators #####
Name | Signature|Function
---- | ---------|--------
\- (minus)|`<T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Difference

### Int ###
##### Methods #####

Name | Signature
---- | ---------
**`times`**|`times (call: () -> Any)`
**`sleep`**|`sleep ()`
**`isEven`**|`isEven () -> Bool`
**`isOdd`**|`idOdd () -> Bool`

### String ###
##### Operators #####
Name | Signature|Function
---- | ---------|--------
Subscript \[x]|`subscript(index: Int) -> UnicodeScalar?`|Returns the unicode scalare at index *x*

### To Do ###
* Compile as library as soon as XCode 6 stops crashing.
* Benchmark
* ...
