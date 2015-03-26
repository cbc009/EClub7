//
//  Shoop_0Cell.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Shoop_0Cell.h"
#import "RatingBar.h"
@implementation Shoop_0Cell
{
    RatingBar *bar;
}
- (void)awakeFromNib {
    bar = [[RatingBar alloc] initWithFrame:CGRectMake(75, 50, 160, 20)];
    bar.starNumber=4;
    bar.enable=NO;
    [self addSubview:bar];
    //    bar.center.y = 12;
    bar.frame=CGRectMake(self.frame.origin.x+135,65, 100, 20);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
