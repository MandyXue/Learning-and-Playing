//
//  ViewController.m
//  iCampus
//
//  Created by MandyXue on 15/7/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

#import "ViewController.h"
#import "ShopModel.h"

@interface ViewController (){
    NSMutableArray *shopData;
}
@property (nonatomic,strong) ShopModel *currentShop;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getShopDetail];
    [self showShopDetail];
}

-(void)getShopDetail{
    //获取路径，获取plist内容
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopDetail" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    //初始化
    shopData = [[NSMutableArray alloc]init];
    for(NSDictionary * dic in data){
        ShopModel * shop = [ShopModel shopWithDic:dic];
        [shopData addObject:shop];
    }
    for(ShopModel * shop in shopData){
        if(shop.shopId == self.shopId){
            self.currentShop = shop;
            break;
        }else{
            continue;
        }
    }
}

-(void)showShopDetail{
    [self.shopNameLabel setText:self.currentShop.name];
    [self.shopTelLabel setText:self.currentShop.tel];
    [self.shopMenuImg setImage:[UIImage imageNamed:self.currentShop.image]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
