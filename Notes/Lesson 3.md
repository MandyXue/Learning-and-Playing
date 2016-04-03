#-- Class Three --

### Create Model File
Our model is completely UI independent
it doesn’t inherit
it doesn’t subclass any iOS class or anything

=====

### Initialize an array
not preferred, although it’s clear:
```swift
var opStack = Array<Op>()
```
preferred:
```swift
var opStack = [Op]()
```
This is an alternate syntax
if you ever initialize an array, this way will be better

And it is the same when initializing a dictionary, but a little difference.
Before:
```swfit
var knownOps = Dictionary<String, Op>()
```
But we prefer, so we change it into:
```swift
var knownOps = [String:Op]()
```
We use a ":" here to mean dictionary

=====

### Enum in Swift
* no inheritance for enum
* can have functions
* can have properties, but only computed properties

#### Enums are great when you have sth. that can be one thing one time and a different thing another time, never both at the same time:
```swift
enum Op {
    case Operand
    case Operation
}
```
And you can associate data with any of the cases in the enum:
```swift
enum Op {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)              //一元运算
    case BinaryOperation(String, (Double,Double) -> Double)    //二元运算
}
```

=====

### API
Create API for calculation:
```swift
func pushOperand(operand: Double){
    opStack.append(Op.Operand(operand))
}
```

=====

### Create an Initializer

if we write:
```swift
let brain = CalculatorBrain()   //with no arguments
```
it will call the init():
```swift
init(){
    knownOps["×"] = Op.BinaryOperation("×") { $0 * $1 }
    knownOps["÷"] = Op.BinaryOperation("÷") { $1 / $0 }
    knownOps["−"] = Op.BinaryOperation("−") { $1 - $0 }
    knownOps["+"] = Op.BinaryOperation("+") { $0 + $1 }
    knownOps["√"] = Op.UnaryOperation("√") { sqrt($0) }
}
```

=====

### More about Closure

We can replace the last Closure by:
```swift
knownOps["√"] = Op.UnaryOperation("√", sqrt)
```
Because the function here can be a named function or we could use curly braces.
In Swift, all the operators, times, etc. are just functions, so that they can infix between the two arguments that we take from the "()":
```swift
knownOps["×"] = Op.BinaryOperation("×", *)   //multiply
knownOps[“+"] = Op.BinaryOperation(“+", *)   //add
```
But the order of minus and divides is backwards so we can’t do this to them.

### How to look up sth. in Dictionary:
```swift
let operation = knownOps[symbol]
```
And this “operation” is an optional because maybe you can’t find it in the dictionary, and it will returns nil.

### Access Control

It's about public and private.
If you want sth. to be private you can put “private” before it.
If you don’t put anything, it will be public in the program.
And you only use the word public if you’re shipping out like a framework of objects to other people and you want the methods there to be public outside the framework.

=====

### More about Optional

If the user input wrong things that cannot be evaluated like “+” at first, we want to return sth. to tell them that they are wrong, like nil, so we use optional here:
```swift
func evaluate() -> Double?
```
This is a classic case of using optional.

=====

### Tuple:
You can combine multiple things together into one kind of mini data structure called tuple.
We can just put all the things we want in a "()" and with “,” to separate them, like ```(Double?, [Op])```, and we can name each value, like ```(result: Double?, remainingOps: [Op])```

### Pass by Value in Swift
```swift
let op = ops.removeLast()
```
When you pass arguments to functions, unless you’re passing an instance of a class, the thing you pass is copied.

* Arrays and Dictionary are structs, not class
* Two huge differences between structs and classes:
   1. Classes can have inheritance
   2. Structs are passed by value and classes are passed by reference

There is an implicit ‘let’ in front of all things you pass, like
```swift
func evaluate(let ops: [Op]) -> (result: Double?, remainingOps: [Op])
```
So they are read only and a read only array can’t be mutated.
And Swift only make a copy when you actually mutate the variable.

### “_” in Swift
means don’t care, like:
```swift
case .UnaryOperation(_, let operation)
```

=====

### Recursion in this Stack

The finished code is:
```swift
private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
    if !ops.isEmpty {
        var remainingOps = ops
        let op = remainingOps.removeLast()
        switch op {
        case .Operand(let operand):
            return (operand, remainingOps)
        case .UnaryOperation(_, let operation):
            let operandEvaluation = evaluate(remainingOps)
            if let operand = operandEvaluation.result {
                return (operation(operand), operandEvaluation.remainingOps)
            }
        case .BinaryOperation(_, let operation):
            let op1Evaluation = evaluate(remainingOps)
            if let operand1 = op1Evaluation.result {
                let op2Evaluation = evaluate(remainingOps)
                if let operand2 = op2Evaluation.result{
                    return (operation(operand1, operand2), op2Evaluation.remainingOps)
                }
            }
        }
    }
    return (nil, ops)
}

func evaluate() -> Double? {
    let (result,remainder) = evaluate(opStack)
    return result
}
```

### Description
```swift
var description: String {
    get {
        switch self {
        case .Operand(let operand):
            return "\(operand)"
        case .UnaryOperation(let symbol, _):
            return symbol
        case .BinaryOperation(let symbol, _):
            return symbol
        }
    }
}
```

=====

### Protocol

It's not inherence
Means: you’re telling swift that this enum implements whatever is in this protocol.
And this protocol happens to just be one computed property called Description that returns the string
e.g.
```swift
private enum Op: Printable {
    case Operand(Double)
    case UnaryOperation(String, Double -> Double)              //一元运算
    case BinaryOperation(String, (Double,Double) -> Double)    //二元运算
    
    var description: String {
        get {
            switch self {
            case .Operand(let operand):
                return "\(operand)"
            case .UnaryOperation(let symbol, _):
                return symbol
            case .BinaryOperation(let symbol, _):
                return symbol
            }
        }
    }
}
```

### Add Operations more easily
```swift
init(){
    func learnOp(op: Op){
        knownOps[op.description] = op
    }
    learnOp(Op.BinaryOperation("×", *))
    learnOp(Op.BinaryOperation("÷") { $1 / $0 })
    learnOp(Op.BinaryOperation("−") { $1 - $0 })
    learnOp(Op.BinaryOperation("+", +))
    learnOp(Op.UnaryOperation("√", sqrt))
}
```
