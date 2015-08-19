//
//  ViewController.swift
//  Calculator
//
//  Created by MandyXue on 15/8/12.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //TODO: clear button
    @IBOutlet weak var display: UILabel!
    
    var userIsInTheMiddleOfTypingANumber: Bool = false
    
    var brain = CalculatorBrain()      //Model
    
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
        if let operation = sender.currentTitle{
            if let result = brain.performOperation(operation){
                displayValue = result
            } else {
                displayValue = 0
            }
        }
    }
    
    var operateStack = Array<Double>()
    
    
    @IBAction func enter() {
        userIsInTheMiddleOfTypingANumber = false
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        } else {
            displayValue = 0
        }
    }
    
    //TODO: turning displayValue into optional
    var displayValue: Double {
        get{
            return (NSNumberFormatter().numberFromString(display.text!)?.doubleValue)!
        }
        set{
            display.text = "\(newValue)"
        }
    }
}

