//
//  KillDetailViewController.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Kills.h"
#import "Kill_CountDown.h"
@interface KillDetailViewController : UIViewController<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *buyButton;
@property (nonatomic,strong)NSArray *datas;
@property(nonatomic,strong)KillGood *good;
- (IBAction)segAction:(UISegmentedControl *)sender;
@end
