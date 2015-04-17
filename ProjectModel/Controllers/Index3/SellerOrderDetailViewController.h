//
//  SellerOrderDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-4-7.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Order_model.h"
@interface SellerOrderDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)Seller_Order_model_arr_order_info *model;
@end
