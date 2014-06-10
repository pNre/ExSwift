#NSArray

### Contents ###

- [NSArray](#nsarray)
    - [Instance Methods](#instance-methods)
    	- [`cast`](#cast)
    	- [`flatten`](#flatten)

### Instance Methods ###

##### `cast` #####
*Pay attention: Any NSNumber is always converted to Bool, Int, Float, ...*

```
let array = ["A", 10, "B", "C", false]
array.cast() as Int[]
// → ([10, 0])
```

##### `flatten` #####
```
let array = [5, [6, ["A", 7]], 8]
array.flatten() as Int[]
// → [5, 6, 7, 8]
```
