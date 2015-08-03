//
//  ViewController.h
//  iCampus
//
//  Created by MandyXue on 15/7/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shopTelLabel;
@property (weak, nonatomic) IBOutlet UIImageView *shopMenuImg;

@property NSInteger shopId;

@end

