//
//  GroupDetailCell.h
//  Club
//
//  Created by MartinLi on 15-4-15.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetailCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *times;
@property (nonatomic,assign) NSInteger end_seconds;
@end

