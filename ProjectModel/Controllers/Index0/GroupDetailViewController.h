//
//  GroupDetailViewController.h
//  Club
//
//  Created by MartinLi on 14-10-15.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Seller_Goods.h"
@interface GroupDetailViewController : UIViewController<UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@property(strong,nonatomic) NSArray *datas;
//- (IBAction)segMented:(UISegmentedControl *)sender;
@property(nonatomic,strong)Seller_Seller_Goods_arr_goods_info *groupGood;
- (IBAction)buyNow:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buyAction;


@end
