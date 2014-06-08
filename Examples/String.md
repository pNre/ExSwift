#String

### Contents ###

- [String](#string)
	- [Properties](#properties)
    - [Instance Methods](#instance-methods)
    	- [`length`](#length)
    	- [`explode`](#explode)
    - [Class Methods](#class-methods)
    	- [`random`](#random)
    - [Operators](#operators)
    	- [Subscript](#subscript)
    	- [Subscript with range](#subscript-with-range)
    	- [Multiplication](#multiplication)


### Properties ###
--
##### `length` #####
```
"Hi".length
// → 2
```

### Instance Methods ###
--

##### `explode` #####
```
let string = "A B C"
string.explode(" ")
// → ["A", "B", "C"]
```

### Class Methods ###
--
##### `random` #####
```
String.random(length: 5)
// → fja92
```

### Operators ###
--
#### Subscript ####
```
let str = "Hello"
println(str[1])
// → e
```

#### Subscript with Range ####
```
let str = "Hello"

println(str[0..2])
// → He

println(str[0...2])
// → Hel
```

#### Multiplication ####
```
println("A" * 3)
// → AAA
```