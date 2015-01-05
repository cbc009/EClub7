//
//  RequestCell.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RequestCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lableHeight;
@property (weak, nonatomic) IBOutlet UILabel *name;
@end
