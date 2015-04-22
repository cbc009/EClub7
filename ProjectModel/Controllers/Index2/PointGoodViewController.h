//
//  PointGoodViewController.h
//  Club
//
//  Created by MartinLi on 14-12-4.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Seller_Goods.h"
@interface PointGoodViewController : UIViewController<UIAlertViewDelegate>
@property (assign ,nonatomic) NSInteger gid;
@property (assign ,nonatomic) NSInteger goods_num;
@property (strong ,nonatomic) NSArray *datas;
@property  (strong,nonatomic) Seller_Seller_Goods_arr_goods_info *models;
@property (weak, nonatomic) IBOutlet UIButton *pointBuy;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
- (IBAction)share:(id)sender;

@end
