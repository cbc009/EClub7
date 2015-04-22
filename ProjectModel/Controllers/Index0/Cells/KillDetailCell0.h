//
//  KillDetailCell0.h
//  Club
//
//  Created by MartinLi on 15-4-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface KillDetailCell0 : UITableViewCell
@property (nonatomic,assign) NSInteger starttime;
@property (weak, nonatomic) IBOutlet UILabel *countDown;
@property (nonatomic,assign) NSInteger endtime;
@end
