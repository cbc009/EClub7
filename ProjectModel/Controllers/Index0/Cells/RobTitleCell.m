//
//  RobTitleCell.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RobTitleCell.h"

@implementation RobTitleCell
{
    NSTimer *timwer;
}
- (void)awakeFromNib {
    timwer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}
-(void)countDownTimer{
    if (self.starttime>0) {
        self.starttime=self.starttime-1;
        self.times.text= [NSString stringWithFormat:@"距离开始还有:%@",[self toDetailTime:self.starttime]];
    }else{
        if (self.endtime>0){
            self.endtime=self.endtime-1;
            self.times.text= [NSString stringWithFormat:@"距离结束还有:%@",[self toDetailTime:self.endtime]];
        }else{
            [timwer invalidate];
        }
    }

    
}
/*
 秒转化成详细时间
 */
-(NSString *)toDetailTime:(NSInteger)seconds{
    int second = seconds % 60;
    int minute = (seconds-second)/60%60;
    int hour = (seconds-second-minute*60)/60/60%24;
    //    int day = (seconds-second-minute*60-hour*60*24)/60/60/24%24;
    NSString *detailTime = [NSString stringWithFormat:@"%d:%d:%d",hour,minute,second];
    return detailTime;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
