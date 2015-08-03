//
//  ViewController.m
//  PopViewTest
//
//  Created by MandyXue on 15/8/3.
//  Copyright © 2015年 MandyXue. All rights reserved.
//

#import "ViewController.h"
#import <pop/POP.h>

@interface ViewController ()
- (IBAction)basicAnimation:(id)sender;
- (IBAction)springAnimation:(id)sender;
- (IBAction)startBtn:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)basicAnimation:(id)sender {
    POPBasicAnimation *anim = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    anim.toValue = @(self.square.center.y+100);
    anim.beginTime = CACurrentMediaTime();
    [self.square pop_addAnimation:anim forKey:@"position"];
    NSLog(@"start animation");
}

- (IBAction)springAnimation:(id)sender {
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    anim.toValue = @(self.square.center.x+300);
    anim.beginTime = CACurrentMediaTime();
    anim.springBounciness = 10.0f;
    [self.square pop_addAnimation:anim forKey:@"position"];
}

- (IBAction)startBtn:(id)sender {
    POPAnimatableProperty *prop = [POPAnimatableProperty propertyWithName:@"countdown" initializer:^(POPMutableAnimatableProperty *prop) {
        
        prop.writeBlock = ^(id obj, const CGFloat values[]) {
            self.timeLabel.text = [NSString stringWithFormat:@"%02d:%02d:%02d",(int)values[0]/60,(int)values[0]%60,(int)(values[0]*100)%100];
        };
        
        //        prop.threshold = 0.01f;
    }];
    
    POPBasicAnimation *anBasic = [POPBasicAnimation linearAnimation];   //秒表当然必须是线性的时间函数
    anBasic.property = prop;    //自定义属性
    anBasic.fromValue = @(0);   //从0开始
    anBasic.toValue = @(3*60);  //180秒
    anBasic.duration = 3*60;    //持续3分钟
    anBasic.beginTime = CACurrentMediaTime();    //延迟1秒开始
    [self.timeLabel pop_addAnimation:anBasic forKey:@"countdown"];
}
@end
