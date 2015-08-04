//
//  ViewController.swift
//  MyCalculator
//
//  Created by MandyXue on 15/8/4.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //展示结果
    @IBOutlet weak var resultLabel: UILabel!
    
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
    }
    @IBAction func clearBtn(sender: AnyObject) {
        resultLabel.text = "";
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

