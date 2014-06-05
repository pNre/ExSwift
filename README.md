# ExSwift

JavaScript inspired (lo-dash, underscore) set of Swift extensions for standard types, functions and classes.

### Array ###
Examples in [Examples/Array.md](Examples/Array.md)

##### Instance Methods #####

Name | Signature
---- | ---------
**`first`**|`first () -> T?`
**`last`**|`last () -> T?`
**`get`**|`get (index: Int) -> T?`
**`remove`**|`remove <U: Equatable> (element: U)`
**`take`**|`take (n: Int) -> Array<T>`
**`contains`**|`contains <T: Equatable> (item: T) -> Bool`
**`difference`**|`difference <T: Equatable> (values: Array<T>...) -> Array<T>`
**`intersection`**|`func intersection <U: Equatable> (values: Array<U>...) -> Array<T>`
**`union`**|`func union <U: Equatable> (values: Array<U>...) -> Array<T>`
**`unique`**|`unique <T: Equatable> () -> Array<T>`
**`indexOf`**|`func indexOf <T: Equatable> (item: T) -> Int`
**`zip`**|`zip (arrays: Array<Any>...) -> Array<Array<Any?>>`
**`shuffle`**|`shuffle ()`
**`shuffled`**|`shuffled () -> Array<T>`
**`sample`** *(random)*|`sample (size n: Int = 1) -> Array<T>`
**`max`**|`max <T: Comparable> () -> T`
**`min`**|`min <T: Comparable> () -> T`
**`each`**|`each (call: (T) -> ())`<br>`each (call: (Int, T) -> ())`
**`any`**|`any (call: (T) -> Bool) -> Bool`
**`all`**|`all (call: (T) -> Bool) -> Bool`
**`reject`**|`reject (exclude: (T -> Bool)) -> Array<T>`
**`pop`**|`pop() -> T`|
**`push`**|`push(newElement: T)`|
**`shift`**|`shift() -> T`|
**`unshift`**|`unshift(newElement: T)`|

##### Class Methods #####

Name | Signatures
---- | ----------
**`range`**|`range <U: ForwardIndex> (range: Range<U>) -> Array<U>`

##### Operators #####
Name | Signature | Function | Usage
---- | --------- | -------- | -----
`-`|`<T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Difference|`[1, 2] - [2, 4] == [1]`
`&`|`<T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|Intersection|`[1, 2] & [2, 4] == [2]`
<code>&#124;</code>|`<T: Equatable> (first: Array<T>, second: Array<T>) -> Array<T>`|union|<code>[1, 2] &#124; [2, 4] == [1, 2, 4]</code>
`[x..y]`<br>`[x...y]`|`subscript(range: Range<Int>) -> Array<T>`|Returns the sub-array from index *x* to index *y*|`var a = [1, 2, 3]; var b = a[1...2]`

### Int ###
##### Instance Methods #####

Name | Signatures | Usage
---- | ---------- | -------
**`times`**|`times <T> (call: (Int) -> T)`<br>`times <T> (call: () -> T)`<br>`times (call: () -> ())`|`3.times({ (index: Int) -> Any in println(index) })`<br>`2.times({ println("Hello") })`
**`after`**|`after <T> (call: () -> T) -> (() -> T?)`|`let a = 2.after({ println("Ciao") })`<br>`f()`<br>`f()`<br>`f() // prints Ciao`
**`sleep`**|`sleep ()`|`2.sleep()`
**`isEven`**|`isEven () -> Bool`|`2.isEven()`
**`isOdd`**|`idOdd () -> Bool`|`1.isOdd()`
**`upTo`**|`upTo (limit: Int, call: (Int) -> ())`|`5.upTo(10, { println($0) })`
**`downTo`**|`downTo (limit: Int, call: (Int) -> ())`|`5.downTo(0, { println($0) })`

##### Class Methods #####

Name | Signatures | Usage
---- | ---------- | -----
**`random`**|`random(min: Int = 0, max: Int) -> Int`|`Int.random(min: 1, max: 1000)`


### Float ###
##### Class Methods #####

Name | Signatures | Usage
---- | ---------- | -----
**`random`**|`random(min: Float = 0, max: Float) -> Float`|`Float.random(min: 1, max: 1000)`

### String ###
##### Instance Methods #####

Name | Signature | Usage
---- | --------- | -----
**`length`**|`length () -> Int`|`"Hi".length() == 2`

##### Class Methods #####

Name | Signature | Usage
---- | --------- | -----
**`random`**|`func random (var length len: Int = 0, charset: String = "...") -> String`|`String.random()`

##### Operators #####
Name | Signature|Function
---- | ---------|--------
`[x]`|`subscript(index: Int) -> String?`|Returns the substring at index *x*
`[x..y]`<br>`[x...y]`|`subscript(range: Range<Int>) -> String`|Returns the substring from index *x* to index *y*
`S * n`|`* (first: String, second: Int) -> String`|Repeats `n` times the string `S`

### Range ###
##### Instance Methods #####

Name | Signatures | Usage
---- | ---------- | -------
**`times`**|`times (call: (T) -> ())`<br>`times (call: () -> ())`|`(2..4).times({ (index: Int) in println(index) })`<br>`(2..4).times({ println("Hi") })`
**`each`**|`each (call: (T) -> ())`|`(2..4).each({ (index: Int) in println(index) })`

### Dictionary ###
Examples in [Examples/Dictionary.md](Examples/Dictionary.md)

##### Instance Methods #####

Name | Signatures
---- | ----------
**`has`**|`has (key: KeyType) -> Bool`
**`isEmpty`**|`isEmpty () -> Bool`
**`map`**|`map(mapFunction map: (KeyType, ValueType) -> (KeyType, ValueType)) -> Dictionary<KeyType, ValueType>`
**`mapValues`**|`mapValues(mapFunction map: (KeyType, ValueType) -> (ValueType)) -> Dictionary<KeyType, ValueType>`
**`each`**|`each(eachFunction each: (KeyType, ValueType) -> ())`
**`filter`**|`filter(testFunction test: (KeyType, ValueType) -> Bool) -> Dictionary<KeyType, ValueType>`
**`merge`**|`merge (dictionaries: Dictionary<KeyType, ValueType>...) -> Dictionary<KeyType, ValueType>`
**`shift`**|`shift () -> (KeyType, ValueType)`

### To Do ###
* Compile as library as soon as XCode 6 stops crashing.
* Benchmark
* ...
