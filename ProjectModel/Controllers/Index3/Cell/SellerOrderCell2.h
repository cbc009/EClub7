//
//  SellerOrderCell2.h
//  Club
//
//  Created by MartinLi on 15-4-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerOrderCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsPic;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UILabel *numb;
@property (weak, nonatomic) IBOutlet UILabel *nums;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *point;
@property (weak, nonatomic) IBOutlet UILabel *amount_red;
@property (weak, nonatomic) IBOutlet UILabel *amount;

@end
