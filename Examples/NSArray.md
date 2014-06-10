#NSArray

### Contents ###

- [NSArray](#nsarray)
    - [Instance Methods](#instance-methods)
    	- [`cast`](#cast)

### Instance Methods ###
*Pay attention: Any NSNumber is always converted to Bool, Int, Float, ...*

##### `cast` #####
```
let array = ["A", 10, "B", "C", false]
array.cast() as Int[]
// → [10, 0]
```
