//
//  KillIndex1_Cell.m
//  Club
//
//  Created by MartinLi on 15/5/21.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "KillIndex1_Cell.h"

@implementation KillIndex1_Cell

- (void)awakeFromNib {
    self.sellerDetails.scrollView.scrollEnabled=NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
