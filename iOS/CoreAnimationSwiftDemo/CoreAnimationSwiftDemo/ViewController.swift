//
//  ViewController.swift
//  CoreAnimationSwiftDemo
//
//  Created by MandyXue on 15/11/21.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    @IBAction func animationOne() {
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 1.0
        animation.toValue = 0.0
        animation.duration = 3.0
        imageView.layer.addAnimation(animation, forKey: nil)
        imageView.layer.opacity = 0.0
    }
    
    @IBAction func animationTwo() {
        imageView.layer.opacity = 1.0
        // create a CGPath that implements two arcs (a bounce)
        let thePath = CGPathCreateMutable()
        CGPathMoveToPoint(thePath, nil, 74.0, 74.0)
        CGPathAddCurveToPoint(thePath, nil, 74.0, 500.0, 320.0, 500.0, 320.0, 74.0)
        CGPathAddCurveToPoint(thePath, nil, 320.0, 500.0, 566.0, 500.0, 566.0, 74.0)
        
        // create the animation object, specifying the position property as the key path.
        let animation = CAKeyframeAnimation(keyPath: "position")
        animation.path = thePath
        animation.duration = 5.0
        imageView.layer.addAnimation(animation, forKey: nil)
    }
    
    @IBAction func animationThree() {
        //animation 1
        let widthAnimation = CAKeyframeAnimation(keyPath: "borderWidth")
        let widthValues = [1.0, 10.0, 5.0, 30.0, 0.5, 15.0, 2.0, 50.0, 0.0]
        widthAnimation.values = widthValues
        widthAnimation.calculationMode = kCAAnimationPaced
        
        //animation 2
        let colorAnimation = CAKeyframeAnimation(keyPath: "borderColor")
        let colorValues = [UIColor.greenColor().CGColor, UIColor.redColor().CGColor, UIColor.blueColor().CGColor]
        colorAnimation.values = colorValues
        colorAnimation.calculationMode = kCAAnimationPaced
        
        //animation group
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [colorAnimation,widthAnimation]
        groupAnimation.duration = 5.0
        
        imageView.layer.addAnimation(groupAnimation, forKey: "borderChanges")
    }

    @IBAction func animationFour() {
        UIView.animateWithDuration(1.0, animations: {
            self.imageView.layer.opacity = 0.0
            
            let animation = CABasicAnimation(keyPath: "position")
            animation.fromValue = NSValue.init(CGPoint: self.imageView.layer.position)
            animation.toValue = NSValue.init(CGPoint: CGPoint.init(x: 150, y: 200))
            animation.duration = 3.0
            self.imageView.layer.addAnimation(animation, forKey: "AnimateFrame")
        })
    }
}


