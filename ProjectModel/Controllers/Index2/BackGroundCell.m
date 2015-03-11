//
//  BackGroundCell.m
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BackGroundCell.h"

@implementation BackGroundCell
{
    float intervalTime;
    float moveWidth;
    float moveWidthReight;
    NSInteger movetypy;
}
- (void)awakeFromNib {
    moveWidth=0.0;
    moveWidthReight=0.0;
    movetypy=0;
    self.moveTimer = [NSTimer scheduledTimerWithTimeInterval:intervalTime target:self selector:@selector(startMoveTimer:) userInfo:nil repeats:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    intervalTime=4;
    [super setSelected:selected animated:animated];
   
    // Configure the view for the selected state
}
-(void)startMoveTimer:(id)sender{
    [self moveType:movetypy];
}
-(void)moveType:(NSInteger)type{
    if (type==0) {
        self.back.frame=CGRectMake(-20+moveWidth, 0, DeviceFrame.size.width+40, 131);
          moveWidth=moveWidth+0.005;
        if (moveWidth>20) {
            movetypy=1;
        }
    }else if (type==1){
        self.back.frame=CGRectMake(-20+moveWidth, 0, DeviceFrame.size.width+40, 131);
        moveWidth=moveWidth-0.005;
        if (moveWidth<-20) {
            movetypy=0;
        }
    }
}

@end
