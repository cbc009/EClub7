//
//  CallHistoryViewCell.h
//  Club
//
//  Created by MartinLi on 14-12-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallHistoryViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *regtime;
@property (weak, nonatomic) IBOutlet UILabel *name;
@end
