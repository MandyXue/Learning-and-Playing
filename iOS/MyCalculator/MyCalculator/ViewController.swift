//
//  ViewController.swift
//  MyCalculator
//
//  Created by MandyXue on 15/8/4.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

//MARK: custom struct: stack
struct Stack<T>{
    private var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
        print("stack push: \(item)")
    }
    mutating func pop() -> T{
        return items.removeLast()
    }
    mutating func top() -> T{
        return items.last!
    }
    internal func count() -> Int{
        return items.count
    }
}
//MARK: custom struct: queue
//用于记录数字
struct Queue<T>{
    private var items = [T]()
    
    mutating func push(item: T) {
        items.append(item)
        print("queue push: \(item)")
    }
    mutating func pop() -> T{
        return items.removeAtIndex(0)
    }
    mutating func first() -> T{
        return items.first!
    }
    mutating func last() -> T{
        return items.last!
    }
    internal func count() -> Int{
        return items.count
    }
}

class ViewController: UIViewController {
    //MARK: button actions
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
    //后退符号响应
    @IBAction func backBtn(sender: AnyObject) {
        if(resultLabel.text?.lengthOfBytesUsingEncoding(NSUTF16StringEncoding)>0){
            resultLabel.text?.removeAtIndex((resultLabel.text?.endIndex.predecessor())!)
        }
    }
    //等于符号响应
    @IBAction func equalBtn(sender: AnyObject) {
        //初始化栈
        let characters = getCharacterWithString()
        let sufExp = getSuffixExpressionWithString(characters)
        let result = getResultWithSuffixExpression(sufExp)
        print(result)
        resultLabel.text = "\(result)"
    }
    //C符号响应
    @IBAction func clearBtn(sender: AnyObject) {
        resultLabel.text = "";
    }
    
    //MARK: life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initBtns()
    }
    
    //MARK: stack methods
//    private func initStack() -> Stack<Character>{
//        var stack = Stack<Character>()
//        if(resultLabel.text! != ""){
//            for character in resultLabel.text!.characters {
//                stack.push(character)
//            }
//        }
////        for _ in 0..<stack.count(){
////            print("stack: \(stack.pop())")
////        }
//        return stack
//    }
    
    private func getCharacterWithString() -> [Character]{
        var chs = [Character]()
        if(resultLabel.text! != ""){
            for character in resultLabel.text!.characters {
                chs.append(character)
            }
        }
        return chs
    }
    
    private func getSuffixExpressionWithString(stmArr: [Character]) -> [Character]{
        var sqStack = Stack<Character>()
        var postExp = [Character]()
        //遍历表达式
        for i in 0..<stmArr.count{
            let ch = stmArr[i]
            if(ch=="+"||ch=="-"){
                //当遇到'+','-' 的时候，如有'('则把其之后的符号出栈，放进postExp数组中，但是'('不出栈，最后把 '+','-'进栈
                //如果没有'(' 那么就把全部的符号出栈，放进postExp数组中，最后在把'+'，'-'进栈
                while(sqStack.count() > 0 && sqStack.top() != "("){
                    let temp = sqStack.pop()
                    postExp.append(temp)
                }
                sqStack.push(ch)
            }else if(ch=="×"||ch=="÷"){
                //当遇到'*','/'的时候， 如栈顶的元素是'*','/'的时候则出栈，一直到遇到'(' 或者栈为空为止
                //最后和遇到'+','-'一样把'*','/'进栈
                if(ch=="×"){
                    sqStack.push("*")
                }else if(ch=="÷"){
                    sqStack.push("/")
                }
                if(sqStack.count() > 0 && sqStack.top() != "(" && (sqStack.top()=="×" || sqStack.top()=="÷")){
                    let temp = sqStack.pop()
                    postExp.append(temp)
                    continue
                }
            }else if(ch=="("){
                //若为 '('，入栈
                sqStack.push(ch)
            }else if(ch==")"){
                //若为 ')'，则依次把栈中的的运算符加入后缀表达式中，直到出现'('，从栈中删除'('
                while(sqStack.count()>0){
                    let temp = sqStack.pop()
                    if(temp != "("){
                        postExp.append(temp)
                    }else{
                        break
                    }
                }
            }else if(ch=="."){
                postExp.append(ch)
            }else{
                //到遇到数字的时候，就一个个取出来，不进栈，而是直接放入到postExp数组中，直到不是数字为止在postExp中加一个'#'以示区别
                postExp.append(ch)
                if(i+2 < stmArr.count && stmArr[i+1] != "." && (stmArr[i+1] < "0" || stmArr[i+1] > "9")){
                    postExp.append("#")
                }
                continue
            }
            print("postExp: \(postExp)")
        }
        //如果栈中还有符号元素，则把它们全部取出，放入postExp数组中
        while(sqStack.count()>0)
        {
            let temp = sqStack.pop()
            postExp.append(temp)
        }
        print("postExp: \(postExp)")
        return postExp
    }
    
    private func getResultWithSuffixExpression(sufExp: [Character]) -> Double{
        var numQue = Queue<Character>()
        var opStack = Stack<Double>()
        for ch in sufExp{
            if((ch >= "0" && ch <= "9" ) || ch == "."){
                //数字的话压入栈中
                numQue.push(ch)
                continue
            }else{
                //“#”即判断数字结束，这时候计算数字并将其压入opStack
                var str = ""
                while(numQue.count()>0){
                    str.append(numQue.pop())
                }
                let temp = NSString(string: str)
                opStack.push(temp.doubleValue)
                print("opstack: \(opStack.items)")
                if(ch == "#"){
                    continue
                }
                if(opStack.count()>0){
                    let op2 = opStack.pop()
                    let op1 = opStack.pop()
                    switch(ch){
                    case "+" : opStack.push(op1 + op2)
                    case "-" : opStack.push(op1 - op2)
                    case "*" : opStack.push(op1 * op2)
                    case "/" : opStack.push(op1 / op2)
                    default : print("wrong")
                    }
                }
                
            }
        }
        print("opstack: \(opStack.items)")
        return opStack.pop()
    }
    
    //Character扩展函数代码
    func toInt(ch: Character) -> Int
        {
            var intFromCharacter:Int = 0
            for i in String(self).utf8
            {
                intFromCharacter = Int(i)
            }
            return intFromCharacter
        }
    
    //MARK: button methods
    private func initBtns(){
        let customGreen = UIColor(red: 138/255, green: 229/255, blue: 177/255, alpha: 1)
        for button in buttonCollection{
            button.setTitleColor(customGreen, forState: UIControlState.Normal)
            button.layer.borderColor = customGreen.CGColor
            button.layer.borderWidth = 2
            button.layer.cornerRadius = 15
        }
        greenBtn.backgroundColor = customGreen
        greenBtn.layer.cornerRadius = 15
    }
}

