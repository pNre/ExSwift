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
    	- [`groupBy`](#groupby) 
    	- [`all`](#all) 
    	- [`any`](#any) 
    	- [`reduce`](#reduce) 
    	
### Instance Methods ###

#### `has` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.has("A") 
// → true
```

#### `isEmpty` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.isEmpty() 
// → false

let e = Dictionary<String, String>()
e.isEmpty() 
// → true
```

#### `each` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.each({ println($0, $1); return }) 
// → (C, 3) (A, 1) (B, 2)
```

#### `map` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let mapped = dictionary.map(mapFunction: { return ($0 + "!", $1 + 1) })
println(mapped) 
// → ["A!": 2, "B!": 3, "C!": 4]
```

#### `mapValues` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let mapped = dictionary.mapValues(mapFunction: { return $1 + 1 })
println(mapped) 
// → ["A": 2, "B": 3, "C": 4]
```

#### `filter` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let filtered = dictionary.filter {
    (key: String, Value: Int) in return key != "A"
}
println(filtered) 
// → ["B": 2, "C": 3]
```

#### `merge` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let merged = dictionary.merge( ["D": 4] )
println(merged) 
// → [ "A": 1, "B": 2, "C": 3, "D": 4 ]
```

#### `groupBy`####

```swift
let group = [
    "A": 2,
    "B": 4,
    "C": 5
]

let g = group.groupBy(groupingFunction: {
    (key: String, value: Int) -> Bool in
    return (value % 2 == 0)
})

// → [false: [5], true: [2, 4]]
```

#### `any` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.any {
    (key: String, value: Int) -> Bool in
    return value % 2 == 0
}
// → true
```

#### `all` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.all {
    (key: String, value: Int) -> Bool in
    return value % 2 == 0
}
// → false
```

#### `reduce` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
let reduced = dictionary.reduce(Dictionary<Int, String>(), {
    (var initial: Dictionary<Int, String>, couple: (String, Int)) in
    initial.updateValue(couple.0, forKey: couple.1)
    return initial
})
// → [2: "B", 3: "C", 1: "A"]
```
