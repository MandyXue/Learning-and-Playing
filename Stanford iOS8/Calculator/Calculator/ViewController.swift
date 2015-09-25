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
    var operateStack = [Double]()
    var lastResult = [Double]()
    
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
//                if (lastResult.isEmpty){
//                    self.result.text = brain.printProcess(result, lastResult: nil)
//                }else if(lastResult.count == 1){
//                    self.result.text = brain.printProcess(result, lastResult: lastResult.removeLast())
//                }else{
//                    self.result.text = brain.printProcess(lastResult.removeLast(), lastResult: lastResult.removeLast())
//                }
                displayValue = result
                lastResult.append(result)
                
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
    
    @IBAction func backspace() {
        if userIsInTheMiddleOfTypingANumber{
            if (display.text != nil){
                var displayChar = changeStrToChars(display.text)
                displayChar.removeLast()
                display.text = changeCharsToStr(displayChar)
            }else{
                showAlert()
            }
        }else{
            showAlert()
        }
    }
    
    @IBAction func changeSign() {
        if userIsInTheMiddleOfTypingANumber{
            if display.text != nil {
                //get characters in display.text
                var displayChar = changeStrToChars(display.text)
                //get the first char
                if displayChar.first == "-"{
                    displayChar.removeAtIndex(0)
                } else {
                    displayChar.insert("-", atIndex: 0)
                }
                display.text = changeCharsToStr(displayChar)
            }
        }else{
            if let result = brain.performOperation("-"){
//                if (lastResult.isEmpty){
//                    self.result.text = brain.printProcess(result, lastResult: nil)
//                }else{
//                    self.result.text = brain.printProcess(result, lastResult: lastResult.removeLast())
//                }
                displayValue = result
                lastResult.append(result)
                
            } else {
                displayValue = 0
            }
        }
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
    private func showAlert(){
        //if displayValue is nil, show an alert view
        let alertController = UIAlertController(title: "Wrong input", message: "Please check if you input wrong things.", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
        display.text = ""
    }
    
    private func changeCharsToStr(chars: [Character]) -> String? {
        if chars.isEmpty {
            return nil
        } else {
            var resultStr = ""
            for char in chars {
                resultStr.append(char)
            }
            return resultStr
        }
    }
    
    private func changeStrToChars(str: String?) -> [Character] {
        if str != nil {
            var chars = [Character]()
            for char in str!.characters {
                chars.append(char)
            }
            return chars
        } else {
            return [Character]()
        }
    }
}

