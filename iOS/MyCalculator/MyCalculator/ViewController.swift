//
//  ViewController.swift
//  MyCalculator
//
//  Created by MandyXue on 15/8/4.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

//自定义结构体－－栈（泛性）
struct Stack<T>{
    private var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
    internal func count() -> Int{
        return items.count
    }
}

class ViewController: UIViewController {
    //展示结果
    @IBOutlet weak var resultLabel: UILabel!
    
    //用于设置样式
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet weak var greenBtn: UIButton!
    
    //除了“C”,“=”,“后退”以外的符号响应
    @IBAction func targetBtn(sender: AnyObject) {
        let temp = sender.currentTitle!
        resultLabel.text = resultLabel.text! + temp!
    }
    @IBAction func backBtn(sender: AnyObject) {
        if(resultLabel.text?.lengthOfBytesUsingEncoding(NSUTF16StringEncoding)>0){
            resultLabel.text?.removeAtIndex((resultLabel.text?.endIndex.predecessor())!)
        }
    }
    @IBAction func equalBtn(sender: AnyObject) {
        //初始化栈
        initStack()
    }
    @IBAction func clearBtn(sender: AnyObject) {
        resultLabel.text = "";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        initBtns()
    }
    
    private func initStack() -> Stack<Character>{
        var stack = Stack<Character>()
        if(resultLabel.text! != ""){
            for character in resultLabel.text!.characters {
                stack.push(character)
            }
        }
//        for _ in 0..<stack.count(){
//            print("stack: \(stack.pop())")
//        }
        return stack
    }
    
    private func initBtns(){
        for button in buttonCollection{
            button.layer.borderColor = UIColor(red: 138/255, green: 229/255, blue: 177/255, alpha: 1).CGColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 15
        }
        greenBtn.layer.cornerRadius = 15
    }

}

