//
//  KillDetailCell0.m
//  Club
//
//  Created by MartinLi on 15-4-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "KillDetailCell0.h"

@implementation KillDetailCell0
{
    NSTimer *timer;
    int second;
    int minute;
    int hour;
    int day;
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
        [self toDetailTime:self.starttime];
        const CGFloat fontSize = 15;
        const CGFloat fontSize1 = 18;
        
        NSUInteger length1 = [[NSString stringWithFormat:@"%d",day] length];
        NSUInteger length2 = [[NSString stringWithFormat:@"%d",hour] length];
        NSUInteger length3 = [[NSString stringWithFormat:@"%d",minute] length];
        NSUInteger length4 = [[NSString stringWithFormat:@"%d",second] length];
        
        NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"还有%d天%d小时%d分%d秒",day,hour,minute,second]];
        
        UIFont *baseFont = [UIFont systemFontOfSize:fontSize1];
        UIFont *baseFont1 = [UIFont systemFontOfSize:fontSize];
        UIColor *color = [UIColor redColor];
        UIColor *color1 =[UIColor blackColor];
        //
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(0, 2)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(0, 2)];
        
        
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(2, length1)];
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(2, length1)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2, 1)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2, 1)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+2+1, length2)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+2+1, length2)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2+1+length2, 2)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2+1+length2, 2)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+2+1+length2+2, length3)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+2+1+length2+2, length3)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2+1+length2+2+length3, 1)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2+1+length2+2+length3, 1)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+2+1+length2+2+length3+1, length4)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+2+1+length2+2+length3+1, length4)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2+1+length2+2+length3+1+length4, 1)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2+1+length2+2+length3+1+length4, 1)];
        
        self.countDown.attributedText= attrString;
    }
}
-(void)toDetailTime:(NSInteger)seconds{
        second= seconds % 60;
        minute= (seconds-second)/60%60;
        hour= (seconds-second-minute*60)/60/60%24;
        day = (seconds-second-minute*60-hour*60*24)/60/60/24%24;
        //    NSString *detailTime = [NSString stringWithFormat:@"%d:%d:%d",hour,minute,second];
        //    return detailTime;
    }
@end
