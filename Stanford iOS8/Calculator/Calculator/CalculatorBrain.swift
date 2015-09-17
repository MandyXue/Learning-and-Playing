//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by MandyXue on 15/8/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

import Foundation

class CalculatorBrain {
    
    private enum Op: Printable {
        case Operand(Double)
        case UnaryOperation(String, Double -> Double, (Double -> String?)?)              //一元运算
        case BinaryOperation(String, Int, (Double,Double) -> Double, ((Double,Double) -> String?)?)    //二元运算
        
        var description: String {
            get {
                switch self {
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _, _):
                    return symbol
                case .BinaryOperation(let symbol, _, _, _):
                    return symbol
                }
            }
        }
        
        //优先级
        var precedence: Int {
            get {
                switch self {
                case .BinaryOperation(_, let precedence, _, _):
                    return precedence
                default:
                    return Int.max
                }
            }
        }
    }
    
    private var opStack = [Op]()
    
    private var knownOps = [String:Op]()
    
    //learn operations
    init(){
        func learnOp(op: Op){
            knownOps[op.description] = op
        }
        learnOp(Op.BinaryOperation("×", 2, *, nil))
        learnOp(Op.BinaryOperation("÷", 2, { $1 / $0 }, {divisor, _ in return divisor == 0.0 ? "Division by Zero" : nil }))
        learnOp(Op.BinaryOperation("−", 1, { $1 - $0 },nil))
        learnOp(Op.BinaryOperation("+", 1, +, nil))
        learnOp(Op.UnaryOperation("√", sqrt, { $0 < 0 ? "Sqrt of negative number" : nil }))
        learnOp(Op.UnaryOperation("sin", sin, nil))
        learnOp(Op.UnaryOperation("cos", cos, nil))
        learnOp(Op.UnaryOperation("-", { -$0 }, nil))
    }
    
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
    
    var procedure: String {
        get {
            var (result,ops) = ("", opStack)
            while ops.count > 0 {
                var current : String?
//                (current, ops, _)
                
            }
            return ""
        }
    }
    
    private var error: String?
    //has draw this to contents of it in a human readable form
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        if !ops.isEmpty {
            var remainingOps = ops
            let op = remainingOps.removeLast()
            
            switch op {
            case .Operand(let operand):
                return (operand, remainingOps)
            case .UnaryOperation(_, let operation, let errorTest):
                let operandEvaluation = evaluate(remainingOps)
                
                if let operand = operandEvaluation.result {
                    if let errorMessage = errorTest?(operand) {
                        error = errorMessage
                        return (nil, operandEvaluation.remainingOps)
                    }
                    return (operation(operand), operandEvaluation.remainingOps)
                }
            case .BinaryOperation(_, _, let operation,let errorTest):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result {
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        if let errorMessage = errorTest?(operand1,operand2) {
                            error = errorMessage
                            return (nil, op2Evaluation.remainingOps)
                        }
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double? {
        let (result,remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    func pushOperand(operand: Double) -> Double? {
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func performOperation(symbol: String) -> Double? {
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        return evaluate()
    }
    
    //TODO: 若运算数字都取自历史怎么办？
//    func printProcess(thisResult: Double?, lastResult:Double?) -> String? {
//        var opStackCopy = opStack
//        var process:String = ""
//        if(!opStackCopy.isEmpty){
//            // get the operation
//            let op = opStackCopy.removeLast()
//            switch op {
//            case .Operand(let operand):
//                return "\(operand)"
//            case .UnaryOperation(let operation, _):
//                let operand = opStackCopy.removeLast()
//                if knownOps[operand.description] == nil{
//                    return "\(operation) \(operand) = \(thisResult!)"
//                }else{
//                    if(lastResult == nil){
//                        return nil
//                    }else{
//                        return "\(operation) \(lastResult!) = \(thisResult!)"
//                    }
//                }
//            case .BinaryOperation(let operation, _):
//                let operand1 = opStackCopy.removeLast()
//                let operand2 = opStackCopy.removeLast()
//                if knownOps[operand2.description] == nil{
//                    return "\(operand2) \(operation) \(operand1) = \(thisResult!)"
//                }else{
//                    if(lastResult == nil){
//                        return nil
//                    }else{
//                        return "\(lastResult!) \(operation) \(operand1) = \(thisResult!)"
//                    }
//                }
//            }
//        }
//        return nil
//    }
}