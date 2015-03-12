//
//  RobCell.m
//  Club
//
//  Created by MartinLi on 15-3-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "RobCell.h"

@implementation RobCell
{
    NSTimer *timer;
}
- (void)awakeFromNib {
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
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
        self.times.text=@"今天抢购已结束";
        self.robNow.backgroundColor=[UIColor grayColor];
        [timer invalidate];
    }
    }
}
-(NSString *)toDetailTime:(NSInteger)seconds{
    int second = seconds % 60;
    int minute = (seconds-second)/60%60;
    int hour = (seconds-second-minute*60)/60/60%24;
    //    int day = (seconds-second-minute*60-hour*60*24)/60/60/24%24;
    NSString *detailTime = [NSString stringWithFormat:@"%d:%d:%d",hour,minute,second];
    return detailTime;
}
@end
