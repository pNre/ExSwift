#Dictionary
### Contents ###

- [Dictionary](#dictionary)
    - [Instance Methods](#instance-methods)
    	- [`has`](#has)
    	- [`isEmpty`](#isempty)
    	- [`map`](#map)
    	- [`mapValues`](#mapvalues)
    	- [`each`](#each)
    	- [`filter`](#filter)
    	- [`merge`](#merge)
    	- [`shift`](#shift) 
    	
### Instance Methods ###

#### `has` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.has("A") // true
```
#### `isEmpty` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.isEmpty() // false
let e = Dictionary<String, String>()
e.isEmpty() // true
```

#### `each` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.each({ println($0, $1); return }) // (C, 3) (A, 1) (B, 2)
```

#### `map` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let mapped = dictionary.map(mapFunction: { return ($0 + "!", $1 + 1) })
println(mapped) // ["A!": 2, "B!": 3, "C!": 4]
```

#### `mapValues` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let mapped = dictionary.mapValues(mapFunction: { return $1 + 1 })
println(mapped) // ["A": 2, "B": 3, "C": 4]
```

#### `filter` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let filtered = dictionary.filter {
    (key: String, Value: Int) in return key != "A"
}
println(filtered) // ["B": 2, "C": 3]
```

#### `merge` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let merged = dictionary.merge( ["D": 4] )
println(merged) // [ "A": 1, "B": 2, "C": 3, "D": 4 ]
```
