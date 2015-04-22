//
//  ShoopsDetailCell.h
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopsDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *seller_status;
@property (weak, nonatomic) IBOutlet UILabel *work_time;
@property (weak, nonatomic) IBOutlet UILabel *street;
@property (weak, nonatomic) IBOutlet UILabel *sellerType;
@property(nonatomic,assign) CGFloat starNumber;
@property (weak, nonatomic) IBOutlet UILabel *logistics;
@end
