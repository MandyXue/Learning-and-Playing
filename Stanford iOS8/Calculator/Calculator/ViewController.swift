//
//  ViewController.swift
//  Calculator
//
//  Created by MandyXue on 15/8/12.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: model & variables
    var brain = CalculatorBrain()      //Model
    var userIsInTheMiddleOfTypingANumber: Bool = false
    var operateStack = Array<Double>()
    var lastResult: Double?
    
    //MARK: controllers
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var result: UILabel!
    
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
                self.result.text = brain.printProcess(result, lastResult: lastResult)
                displayValue = result
                lastResult = result
            } else {
                displayValue = 0
            }
        }
    }
    
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
            showAlert()
        }
    }
    
    @IBAction func clearBtn() {
        display.text = ""
        result.text = ""
        brain = CalculatorBrain()
    }
    
    //MARK: setter & getter
    //finished: turning displayValue into optional
    var displayValue: Double? {
        get{
            //use a number fomatter to convert string with a decimal point into double
            let formatter = NSNumberFormatter()
            formatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            
            if(display.text! == "π"){
                return M_PI;
            }else if((display.text!.rangeOfString("π")) != nil){
                var displayArray = display.text!.componentsSeparatedByString("π")
                if (displayArray.count == 2){ //if it not only has "π", like "3π"
                    if(displayArray[0] == ""){
                        return (formatter.numberFromString(displayArray[1])?.doubleValue)! * M_PI
                    }else if(displayArray[1] == ""){
                        return (formatter.numberFromString(displayArray[0])?.doubleValue)! * M_PI
                    }
                }
            }
            
            if(formatter.numberFromString(display.text!)?.doubleValue != nil){
                return (formatter.numberFromString(display.text!)?.doubleValue)!
            }else{
                showAlert()
            }
            
            return nil
        }
        set{
            display.text = "\(newValue!)"
        }
    }
    
    //MARK: customer functions
    //alert view
    func showAlert(){
        //if displayValue is nil, show an alert view
        let alertController = UIAlertController(title: "Wrong input", message: "Please check if you input wrong things.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        display.text = ""
    }
    
}

