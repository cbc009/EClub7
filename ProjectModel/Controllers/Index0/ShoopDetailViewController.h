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
@property (nonatomic,assign)NSInteger index;//这里的index使用来显示默认选中的下拉菜单的
@property (nonatomic,strong)NSMutableArray *data;
//@property (nonatomic,retain)Public_Seller_arr_seller_type_info *models;
@property (nonatomic,strong)NSArray *cateArray;
@property (nonatomic,strong)NSArray *distanceArray;
@end
