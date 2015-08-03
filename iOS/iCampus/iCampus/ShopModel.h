//
//  ShopModel.h
//  iCampus
//
//  Created by MandyXue on 15/7/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShopModel : NSObject

@property NSUInteger shopId;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *tel;
@property(nonatomic, strong) UIImage *image;

+(instancetype)shopWithDic:(NSDictionary *)dic;


@end
