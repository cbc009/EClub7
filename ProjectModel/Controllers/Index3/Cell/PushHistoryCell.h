//
//  PushHistoryCell.h
//  Club
//
//  Created by MartinLi on 14-11-23.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PushHistoryCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *news;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelHeight;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
