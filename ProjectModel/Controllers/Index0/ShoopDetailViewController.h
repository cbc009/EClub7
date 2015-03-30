//
//  ShoopDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Public_Seller.h"
@interface ShoopDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSString *seller_type;
@property (nonatomic,strong)NSArray *data;
//@property (nonatomic,retain)Public_Seller_arr_seller_type_info *models;
@property (nonatomic,strong)NSArray *cateArray;
@end
