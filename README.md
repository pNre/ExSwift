# ExSwift

JavaScript inspired (lo-dash, underscore) set of Swift extensions for standard types, functions and classes.

### Array ###

##### Instance Methods #####

Name | Signature | Usage
---- | --------- | -------
**`first`**|`first () -> T?`|`[1, 2, 3].first() == 1`
**`last`**|`last () -> T?`|`[1, 2, 3].last() == 3`
**`get`**|`get (index: Int) -> T?`|`[1, 2, 3].get(1) == 2`
**`take`**|`take (n: Int) -> Array<T>`|`[1, 2, 3].take(2) == [1, 2]`
**`contains`**|`contains <T: Equatable> (item: T) -> Bool`|`["A", "B"].contains("B")`
**`difference`**|`difference <T: Equatable> (values: Array<T>...) -> Array<T>`|`[1, 2].difference([2, 4]) == [1]`
**`intersection`**|`func intersection <U: Equatable> (values: Array<U>...) -> Array<T>`|`[1, 2].intersection([2, 4]) == [2]`
**`union`**|`func union <U: Equatable> (values: Array<U>...) -> Array<T>`|`[1, 2].union([2, 4]) == [1, 2, 4]`
**`indexOf`**|`func indexOf <T: Equatable> (item: T) -> Int`|`["A", "B", "C"].indexOf("B") == 1`
**`zip`**|`zip (arrays: Array<Any>...) -> Array<Array<Any?>>`|`[1, 2].zip(["A", "B"]) == [[1, "A"], [2, "B"]]`
**`shuffle`**|`shuffle ()`|`var r = [0, 1, 2]`<br>`r.shuffle()`
**`shuffled`**|`shuffled () -> Array<T>`|`var s = [0, 1, 2].shuffled()`
**`sample`** *(random)*|`sample (size n: Int = 1) -> Array<T>`|`[1, 2, 3].sample()`
**`max`**|`max <T: Comparable> () -> T`|`[5, 10, 2].max() as Int`
**`min`**|`min <T: Comparable> () -> T`|`[5, 10, 2].min() as Int`
**`each`**|`each (call: (T) -> ())`|`[1, 2, 3].each({ println($0) })`
**`any`**|`any (call: (T) -> Bool) -> Bool`|`[1, 2, 3].any({ return $0 % 2 == 0 })`
**`all`**|`all (call: (T) -> Bool) -> Bool`|`[1, 2, 3].all({ return $0 > 0 })`
**`reject`**|`reject (exclude: (T -> Bool)) -> Array<T>`|`[1, 2, 3].reject({ return $0 % 2 == 0 }) == [1, 3]`
**`pop`**|`pop() -> T`|
**`push`**|`push(newElement: T)`|
**`shift`**|`shift() -> T`|
**`unshift`**|`unshift(newElement: T)`|

##### Class Methods #####

Name | Signatures | Usage
---- | ---------- | -------
**`range`**|`range (range: Range<Int>) -> Array<Int>`|`Array<Int>.range(0...2) == [0, 1, 2]`

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
##### Instance Methods #####

Name | Signatures | Usage
---- | ---------- | -------
**`has`**|`has (key: KeyType) -> Bool`|`["A": 2, "B": 3, "C": 4].has("A") == true`
**`map`**|`map(mapFunction map: (KeyType, ValueType) -> (KeyType, ValueType)) -> Dictionary<KeyType, ValueType>`|See [Examples/Dictionary.md](Examples/Dictionary.md)
**`mapValues`**|`mapValues(mapFunction map: (KeyType, ValueType) -> (ValueType)) -> Dictionary<KeyType, ValueType>`|See [Examples/Dictionary.md](Examples/Dictionary.md)|
**`each`**|`each(eachFunction each: (KeyType, ValueType) -> ())`|See [Examples/Dictionary.md](Examples/Dictionary.md)

### To Do ###
* Compile as library as soon as XCode 6 stops crashing.
* Benchmark
* ...
