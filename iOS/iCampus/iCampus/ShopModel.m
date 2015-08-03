//
//  ShopModel.m
//  iCampus
//
//  Created by MandyXue on 15/7/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

#import "ShopModel.h"

@implementation ShopModel

+(instancetype)shopWithDic:(NSDictionary *)dic{
    ShopModel *shop = [[ShopModel alloc]init];
    shop.shopId = [dic[@"shopId"] integerValue];
    shop.name = dic[@"name"];
    shop.tel = dic[@"telephone"];
    shop.image = dic[@"image"];
    return shop;
}

@end
