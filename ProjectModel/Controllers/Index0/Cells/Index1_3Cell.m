//
//  Index1_3Cell.m
//  Club
//
//  Created by MartinLi on 15-4-17.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Index1_3Cell.h"

@implementation Index1_3Cell
{
    UITapGestureRecognizer *tap1;
     UITapGestureRecognizer *tap2;
     UITapGestureRecognizer *tap3;
     UITapGestureRecognizer *tap4;
    UITapGestureRecognizer *tap5;
}
- (void)awakeFromNib {
    tap1= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(robTap)];
    tap2= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(temTap)];
    tap3= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dayTap)];
    tap4= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(killTap)];
    tap5= [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pointTap)];
    [self.robView addGestureRecognizer:tap1];
    [self.teamView addGestureRecognizer:tap2];
    [self.dayView addGestureRecognizer:tap3];
    [self.killView addGestureRecognizer:tap4];
    [self.pointView addGestureRecognizer:tap5];
    self.detailView.layer.cornerRadius=20;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)robTap{
    [self.delegate tapInViewWithTag:1 inCell:self];
}
-(void)temTap{
    [self.delegate tapInViewWithTag:2 inCell:self];
}
-(void)dayTap{
    [self.delegate tapInViewWithTag:3 inCell:self];
}
-(void)killTap{
    [self.delegate tapInViewWithTag:4 inCell:self];
}
-(void)pointTap{
    [self.delegate tapInViewWithTag:5 inCell:self];
}
@end
