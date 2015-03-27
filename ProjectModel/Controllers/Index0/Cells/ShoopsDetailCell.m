//
//  ShoopsDetailCell.m
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopsDetailCell.h"
#import "RatingBar.h"
@implementation ShoopsDetailCell
{
    RatingBar *bar;
}
- (void)awakeFromNib {
    bar = [[RatingBar alloc] initWithFrame:CGRectMake(75, 50, 160, 20)];
    bar.witSize=0.6;
    [self addSubview:bar];
//    bar.witSize=0.6;
    bar.starNumber=2.5;
//    bar.witSize=0.6;
    bar.enable=NO;
    bar.frame=CGRectMake(80, 40, 100, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//- (IBAction)tap:(id)sender {
//    NSLog(@"%ld",(long)bar.starNumber);
//}
@end
