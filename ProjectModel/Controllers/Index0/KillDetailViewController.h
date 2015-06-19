//
//  KillDetailViewController.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Seller_Goods.h"
#import "Kills.h"
#import "Kill_CountDown.h"
@interface KillDetailViewController : UIViewController<UIAlertViewDelegate>

@property (nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)Seller_Seller_Goods_arr_goods_info *good;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)buyNow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *killeNOw;
- (IBAction)share:(id)sender;
@property (nonatomic,assign) NSInteger end_seconds;
@property (nonatomic,assign) NSInteger countDownSeconds;
@end
