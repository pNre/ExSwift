#ExSwift

### Contents ###

- [ExSwift](#exswift)
    - [Class Methods](#class-methods)
    	- [`after`](#after)
    	- [`once`](#once)
    	- [`partial`](#partial)
    	- [`bind`](#bind)
    	
### Class Methods ###

##### `after` #####
```
let f = ExSwift.after(2, { println("Ciao") })
f()
// → 
f()
// → 
f()
// → Ciao
```

##### `once` #####
```
let greet = once { (names: String...) -> () in println("Hello " + names[0]) }

greet("World")
// → Hello World

greet("People")
// → 
```

##### `partial` #####
```
let add = {
    (params: Int...) -> Int in
    return params.reduce(0, { return $0 + $1 })
}

let add5 = ExSwift.partial(add, 5)

add5(10)
// → 15

add5(1, 2)
// → 8
```

##### `bind` #####
```
let concat = {
    (params: String...) -> String in
    return params.implode(" ")!
}
        
let helloWorld = ExSwift.bind(concat, "Hello", "World")

helloWorld()
// → Hello World
```
