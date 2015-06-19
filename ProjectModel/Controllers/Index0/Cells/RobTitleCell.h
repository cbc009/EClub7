//
//  RobTitleCell.h
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SecondCountDownDelegate <NSObject>
//开始倒计时
-(void)countDownActionWithStartSeconds:(NSInteger)seconds andEndSencond:(NSInteger )endSconds;
@end
@interface RobTitleCell : UITableViewCell
@property (weak, nonatomic)id<SecondCountDownDelegate>delegate;
@property (weak, nonatomic) IBOutlet UIImageView *goodPic;
@property (weak, nonatomic) IBOutlet UILabel *goodName;
@property (weak, nonatomic) IBOutlet UILabel *saleNum;
@property (weak, nonatomic) IBOutlet UILabel *goodNum;
@property (weak, nonatomic) IBOutlet UILabel *times;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *marketPrice;
@property (nonatomic,assign) NSInteger starttime;
@property (nonatomic,assign) NSInteger endtime;
@end
