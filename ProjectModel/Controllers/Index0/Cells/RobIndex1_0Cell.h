//
//  RobIndex1_0Cell.h
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RobIndex1_0Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *sellerTitle;
@property (weak, nonatomic) IBOutlet UILabel *selerDetail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *sellerDetailHeight;

@end
