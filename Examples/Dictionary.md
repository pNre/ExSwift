#Dictionary

#### `has` ####
```swift
let dictionary = [ "A": 1, "B": 2, "C": 3 ]
dictionary.has("A") // true
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

