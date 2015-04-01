//
//  CheckCell.h
//  Club
//
//  Created by MartinLi on 15-3-30.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *goodname;
@property (weak, nonatomic) IBOutlet UILabel *numbs;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *totlPrice;

@end
