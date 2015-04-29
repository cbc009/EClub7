//
//  ShowViewController.h
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import "Public_Seller_info_model.h"
@interface ShowViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tablewView;
@property (nonatomic,strong)NSString *seller_id;
@property (nonatomic,strong)Public_Seller_info_model_arr_seller_info *models;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewHeight;
@property (nonatomic,strong)NSArray *datas;
@end
