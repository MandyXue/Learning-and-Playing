//
//  ShopTableViewController.m
//  iCampus
//
//  Created by MandyXue on 15/7/19.
//  Copyright (c) 2015年 MandyXue. All rights reserved.
//

#import "ShopTableViewController.h"
#import "ShopModel.h"
#import "ViewController.h"

@interface ShopTableViewController ()

@property (nonatomic,strong) NSMutableArray * shopArray;

@end

@implementation ShopTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getShopNames];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.shopArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"shopCell"];
    }
    ShopModel * shop = self.shopArray[indexPath.row];
    [cell.textLabel setText:shop.name];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"ShopDetailTableViewController"];
    ShopModel * currentShop = self.shopArray[indexPath.row];
    vc.shopId = currentShop.shopId;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - get shop name
-(void)getShopNames{
    //获取路径，获取plist内容
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"shopDetail" ofType:@"plist"];
    NSMutableArray *data = [[NSMutableArray alloc] initWithContentsOfFile:plistPath];
    //初始化
    self.shopArray = [[NSMutableArray alloc]init];
    for(NSDictionary * dic in data){
        ShopModel * shop = [ShopModel shopWithDic:dic];
        [self.shopArray addObject:shop];
    }
}

@end
