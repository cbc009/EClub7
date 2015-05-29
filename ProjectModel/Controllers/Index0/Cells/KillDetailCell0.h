//
//  KillDetailCell0.h
//  Club
//
//  Created by MartinLi on 15-4-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KillDetailCell0;
@protocol KillSecondCountDownDelegate <NSObject>
//开始倒计时
-(void)startCountDownActionWithSeconds:(NSInteger)seconds;
@end
@interface KillDetailCell0 : UITableViewCell
@property(nonatomic,weak)id<KillSecondCountDownDelegate>delegate;
@property (nonatomic,assign) NSInteger starttime;
@property (weak, nonatomic) IBOutlet UILabel *countDown;
@property (nonatomic,assign) NSInteger endtime;
@end
