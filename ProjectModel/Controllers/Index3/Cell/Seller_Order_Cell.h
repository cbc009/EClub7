//
//  Seller_Order_Cell.h
//  Club
//
//  Created by MartinLi on 15-4-2.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Seller_Order_Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *orderID;
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodStatus;

@end
