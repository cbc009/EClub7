//
//  GroupAdCell.h
//  Club
//
//  Created by MartinLi on 14-12-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MartinLiPageScrollView.h"
@interface GroupAdCell : UITableViewCell
@property (weak, nonatomic) IBOutlet MartinLiPageScrollView *pageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageviewHeight;
@end
