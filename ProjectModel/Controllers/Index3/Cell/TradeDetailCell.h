//
//  TradeDetailCell.h
//  Club
//
//  Created by MartinLi on 15-2-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TradeDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UIImageView *picture;
@end
