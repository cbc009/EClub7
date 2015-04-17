//
//  RobDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Seller_Goods.h"
@interface RobDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)robNow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *robNowButton;
@property(nonatomic,strong)Seller_Seller_Goods_arr_goods_info *robGoodsMOdel;
@end
