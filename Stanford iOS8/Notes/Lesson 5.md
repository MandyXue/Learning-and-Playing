#-- Class Five --

### Objective-c Compatibility

##### Bridging
NSString => String
NSArray => Array<AnyObject>
NSDictionary => Dictionary<NSObject, AnyObject>
Int, FLoat, Double, Bool => NSNumber

### Property List

##### Definition
* An AnyObject which is known to be a collection of objects which are ```only``` one of NS~

##### Using
* pass around data ```blindly```
* used as a ```generic data structure```

##### Good use: NSUserDefaults
e.g.
```swift
//get reader/writer
let defaults = NSUserDefaults.standardUserDefaults()
//read and write
let plist: AnyObject = defaults.objectForKey(String)
//auto save
defaults.setObject(AnyObject, forKey: String)   //AnyObj must be a property list
//force save
if !defaults.synchronize(){/* failed! */}
```

##### Use ```NSUserDefaults``` to improve CalculatorBrain

Turn ```opStack``` into property list
```swift
get{
    var returnValue = Array<String>()
    for op in opStack{
        returnValue.append(op.description)
    }
    return returnValue
}
```
but it's better to use ```map```:
```swift
get{
    return opStack.map { $0.description }
}
```
and the result is:
```swift
var problem: AnyObject { // guaranteed to be a PropertyList
    get{
        return opStack.map { $0.description }
    }
    set{
        if let opSymbols = newValue as? Array<String> {
            var newOpStack = [Op]()
            for opSymbol in opSymbols {
                if let op = knownOps[opSymbol] {
                    newOpStack.append(op)
                } else if let operand = NSNumberFormatter().numberFromString(opSymbol)?.doubleValue {
                    newOpStack.append(.Operand(operand))
                }
            }
            opStack = newOpStack
        }
    }
}
```

### Views

a rectangular area

hierarchical