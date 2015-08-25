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
        //displayValue is an optional
        if ((displayValue) != nil){
            if let result = brain.pushOperand(displayValue!){
                displayValue = result
            } else {
                displayValue = nil
            }
        }else{
            //if displayValue is nil, show an alert view
            let alertController = UIAlertController(title: "Wrong input", message: "Please check if you input wrong things.", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    
    @IBAction func clearBtn() {
        display.text = " "
        brain = CalculatorBrain()
    }
    
    //TODO: turning displayValue into optional
    var displayValue: Double? {
        get{
            if((display.text!.rangeOfString("π")) != nil){
                var displayArray = display.text!.componentsSeparatedByString("π")
                if(displayArray.count == 1){
                    return (M_PI)
                }else if (displayArray.count == 2){ //if it not only has "π", like "3π"
                    if(displayArray[0] == ""){
                        return (NSNumberFormatter().numberFromString(displayArray[1])?.doubleValue)! * M_PI
                    }else if(displayArray[1] == ""){
                        return (NSNumberFormatter().numberFromString(displayArray[0])?.doubleValue)! * M_PI
                    }else{
                        return nil
                    }
                }else {
                    return nil
                }
            }
            return (NSNumberFormatter().numberFromString(display.text!)?.doubleValue)!
        }
        set{
            display.text = "\(newValue)"
        }
    }
}

