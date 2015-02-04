//
//  TradeOrderDetailViewController.h
//  Club
//
//  Created by dongway on 14-9-1.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderDetailData.h"
@interface TradeOrderDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)deleate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property(nonatomic,strong)NSArray *items;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *redbag;
@property (weak, nonatomic) IBOutlet UILabel *amount;
@property (weak, nonatomic) IBOutlet UILabel *totals;
@property (weak, nonatomic) IBOutlet UILabel *shipping;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *scrolleHeight;
@property(nonatomic,strong)NSString *orderid;
@end
