//
//  ViewController.swift
//  Calculator
//
//  Created by MandyXue on 15/8/12.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!
        if userIsInTheMiddleOfTypingANumber {
            display.text = display.text! + digit
        }else{
            display.text = digit
            userIsInTheMiddleOfTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        if(userIsInTheMiddleOfTypingANumber){
            enter()
        }
        switch operation {
        case "×":performOperation { $0 * $1 }
        case "÷":performOperation { $1 / $0 }
        case "+":performOperation { $0 + $1 }
        case "−":performOperation { $1 - $0 }
        case "√":performOperation { sqrt($0) }
        default: break
        }
    }
    
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
    
    var operateStack = Array<Double>()
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        operateStack.append(displayValue)
        print("operateStack = \(operateStack)")
    }
    var displayValue: Double {
        get{
            return (NSNumberFormatter().numberFromString(display.text!)?.doubleValue)!
        }
        set{
            display.text = "\(newValue)"
            userIsInTheMiddleOfTypingANumber = false
        }
    }
}

