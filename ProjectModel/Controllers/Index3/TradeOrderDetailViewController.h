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
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
- (IBAction)deleate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *cancel;
@property(nonatomic,strong)NSArray *items;
@property(nonatomic,strong)NSString *orderid;
@end
