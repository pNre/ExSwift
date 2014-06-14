#String

###Refer to the [Wiki](https://github.com/pNre/ExSwift/wiki/String) for updated info.

### Contents ###

- [String](#string)
	- [Properties](#properties)
    	- [`length`](#length)
    - [Instance Methods](#instance-methods)
    	- [`explode`](#explode)
    	- [`at`](#at)
    	- [`matches`](#matches)
    	- [`capitalized`](#capitalized)
    	- [`insert`](#insert)
    - [Class Methods](#class-methods)
    	- [`random`](#random)
    - [Operators](#operators)
    	- [Subscript](#subscript)
    	- [Subscript with range](#subscript-with-range)
    	- [Multiplication](#multiplication)
    	- [Match](#match)


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

##### `at` #####
```
"ABCD".at(0, 2)
// → ["A", "C"]

"ABCD"[0, 1]
// → ["A", "B"]
```

##### `matches` #####
```
let string = "AB[31]"

let matches = string.matches("\\d+")!
let range = matches[0].rangeAtIndex(0)

string[range.location..(range.location + range.length)]
// → 31
```

##### `capitalized` #####
```
"hello".capitalized()
// → Hello
```

##### `insert` #####
```
"abcdef".insert(3, "X")
// → abcXdef
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

#### Match ####

#####String#####

```
let string = "ABcd"

string =~ "D$"
// → false

string =~ (pattern: "D$", ignoreCase: true)
// → true

string =~ "^A"
// → true
```

#####All the elements in array#####
```
let string = "ABcd"

let strings = [string, string, string]
strings =~ "^A"
// → true
```

#####Any element in array#####
```
let strings = ["ABCD", "492", "no"]
strings |~ "^A"
// → true
```
