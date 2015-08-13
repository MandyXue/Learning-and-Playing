# Stanford iOS Class #
Just some notes for reviewing and memorizing

#-- Class One --

##What's in iOS (Four Layers)

| Cocoa Touch     | Media             | Core Services    | Core OS           |
| --------------- | ----------------- | ---------------- | ----------------- |
| Multi-Touch     | Core Audio        | Collections      | OSX Kernel        |
| Alerts          | JPEG/PNG/TIFF     | Core Location    | Power Management  |
| Core Motion     | OpenAL            | Address Book     | Mach 3.0          |
| View Hierachy   | PDF               | Net Services     | Keychain Access   |
| Localization    | Audio Mixing      | Networking       | BSD               |
| Map Kit         | Quartz(2D)        | Threading        | Certificates      |
| Image Picker    | Audio Recording   | File Access      | Sockets           |
| Controls        | Core Animation    | Preferences      | File System       |
| Camera          | Video Playback    | SQLite           | Security          |
|                 | OpenGL ES         | URL Utilities    | Bonjour           |

##Swift
### Advantages
* Concise
* Type Safe
* Type Inference

### Characteristics
* Single Inheritance: only inherit from one class
* All objects, all class, the instances of classes live in the heap; the memory for them is managed for you; Swift use reference counting
* Outlet: instance, variable, property
* Action: method
* let: constant
* var: variable
* 'let' and 'var' improves readability

### Optional
* a strong type
* type inference
* e.g. ```String?```

#### 1. Optional has two kind of values:
##### (1) not set
* nil

##### (2) something
* String, Int, Double, etc. (Here is ```String```)

#### 2. Optional String
* it's not a String that can be nil
* it's an optional that can be a String

#### 3. Unwrap the optional
* use "!"
* e.g. 
```swift
let digit = sender.currentTitle!
```
* In the example above, if ```sender.currentTitle``` is nil here, when you wrap it, the program will crash.
* But if ```sender.currentTitle``` is String here, digit will be a String.

#-- Class Two --

### difference between "!" and "?" in optional
make no difference to the actual type
different in the usages:

#### UILabel?: optional, doesn’t respond to text
Using:
```swift
//decoration
@IBOutlet weak var display: UILabel?
//usage
display!.text = display!.text! + digit
```

#### UILabel!:
* optional, but always automatically unwrap it
* implicitly unwrapped optional (隐式包解析) like auto explanation point

### Button arguments
* enter button needs no arguments: it just push the key to stack

### Swift is a strongly typed, type inference language
#### Using of Type Inference
##### Example 1
```swift
var operateStack: Array<Double> = Array<Double>()
```
is better replaced by
```swift
var operateStack = Array<Double>()
```
the first one is bad formed because if it can be inferred, you need to let it infer
##### Example 2
```swift
case "×":performOperation({ (op1: Double, op2: Double) -> Double in
            return op1 * op2
            })
```
is better replaced by
```swift
case "×":performOperation({ (op1, op2) in
            return op1 * op2
            })
```

### Computed Properties
#### getter and setter in Swift
```swift
var displayValue: Double {
    get{
        return (NSNumberFormatter().numberFromString(display.text!)?.doubleValue)!
    }
    set{
        display.text = "\(newValue)"
        userIsInTheMiddleOfTypingANumber = false
    }
}
```

### Control Flow Operator in Swift
#### Closure
* put a function in the argument’s place

#### Using Closure and Type Inference to Improve Your Code
The original code:
```swift
case "×":performOperation({ (op1: Double, op2: Double) -> Double in
            return op1 * op2
            })
```
is better replaced by
```swift
case "×":performOperation({ (op1, op2) in
            return op1 * op2
            })
```
and Swift knows you need to return sth. so that is much better replaced by
```swift
case "×":performOperation({ (op1, op2) in op1 * op2 })
```
and Swift doesn’t force you to name these two arguments
if you don’t name it, Swift will use $0, $1, $2, $3, etc.
so the best and shortest way to write this function is that:
```swift
case "×":performOperation({ $0 * $1 })
```
if the argument is the last argument, then you can move the function outside the parentheses, like this:
```swift
case "×":performOperation() { $0 * $1 }
```
if it is the only argument, you can move away the parentheses, like this:
```swift
case "×":performOperation { $0 * $1 }
```

### Override Functions
#### ATTENTION:
```swift
private func performOperation(operation: (Double, Double) -> Double){
    if(operateStack.count >= 2){
        displayValue = operation(operateStack.removeLast(), operateStack.removeLast())
        enter()
    }
}
    
private func performOperation(operation: Double -> Double){
    if(operateStack.count >= 1){
        displayValue = operation(operateStack.removeLast())
        enter()
    }
}
```
We need to put **private** here, check here: [stackoverflow]( http://stackoverflow.com/questions/29457720/compiler-error-method-with-objective-c-selector-conflicts-with-previous-declara)
And I think maybe that's because I'm using Xcode 7.

### autolayout
brief introduction

### MVC
#### Definition
basically a mechanism where we divide up all the objects in our application into one of these three camps:
* **Model**: What your application is (but not how it is displayed)
* **Controller**: How your model is presented to the user (UI logic)
* **View**: your controller’s minions
* **It’s all about managing communication between camps**

#### Here is the whole MVC design pattern picture:
##### single MVC
![Mark-Up](http://blog.devtang.com/images/ios_mvc.jpg)
##### MVC working together
![Mark-Up](https://littlehales.files.wordpress.com/2012/01/mvc2.jpg)
