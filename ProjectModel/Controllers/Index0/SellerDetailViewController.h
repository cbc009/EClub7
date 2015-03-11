//
//  SellerDetailViewController.h
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Seller_Info.h"
@interface SellerDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (nonatomic,strong)NSString *agent_id;
@property (nonatomic,strong)NSString *seller_type;
@property (nonatomic,strong)NSString *seller_id;
@property (nonatomic,strong)Seller_Info_arr_seller *object;
@end
