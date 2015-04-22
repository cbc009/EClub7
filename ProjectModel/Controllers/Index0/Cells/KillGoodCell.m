//
//  KillGoodCell.m
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillGoodCell.h"

@implementation KillGoodCell
{
    NSTimer *timer;
    int second;
    int minute;
    int hour;
    int day;
}
- (void)awakeFromNib {
    second=0;
    minute=0;
    hour=0;
    day=0;
    timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(countDownTimer) userInfo:nil repeats:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)countDownTimer{
    if (self.starttime>0) {
        self.starttime=self.starttime-1;
        [self toDetailTime:self.starttime];
        const CGFloat fontSize = 11;
        const CGFloat fontSize1 = 15;
        
        NSUInteger length1 = [[NSString stringWithFormat:@"%d",day] length];
        NSUInteger length2 = [[NSString stringWithFormat:@"%d",hour] length];
        NSUInteger length3 = [[NSString stringWithFormat:@"%d",minute] length];
        NSUInteger length4 = [[NSString stringWithFormat:@"%d",second] length];
        
        NSMutableAttributedString *attrString =[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%d天%d小时%d分%d秒后开始秒杀",day,hour,minute,second]];
        
        UIFont *baseFont = [UIFont systemFontOfSize:fontSize1];
        UIFont *baseFont1 = [UIFont systemFontOfSize:fontSize];
        UIColor *color = [UIColor redColor];
        UIColor *color1 =[UIColor blackColor];
//
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(0, length1)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(0, length1)];

        
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1, 1)];
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1, 1)];
//
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+1, length2)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+1, length2)];

        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+1+length2, 2)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+1+length2, 2)];

        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+1+length2+2, length3)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+1+length2+2, length3)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2+length2+1+length3, 1)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2+length2+1+length3, 1)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont
                           range:NSMakeRange(length1+2+length2+1+length3+1, length4)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color
                           range:NSMakeRange(length1+2+length2+1+length3+1, length4)];
        
        [attrString addAttribute:NSFontAttributeName value:baseFont1
                           range:NSMakeRange(length1+2+length2+1+length3+1+length4, 6)];
        [attrString addAttribute:(id)NSForegroundColorAttributeName
                           value:color1
                           range:NSMakeRange(length1+2+length2+1+length3+1+length4, 6)];

    self.contDown.attributedText= attrString;
    }else if (self.starttime<-3){
            self.starttime=self.starttime-1;
            self.contDown.text=@"正在进行秒杀";
            self.buyNow.backgroundColor=[UIColor redColor];
    }else{
        self.contDown.text=@"秒杀已结束";
        self.buyNow.backgroundColor=[UIColor grayColor];
        [timer invalidate];
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
