//
//  Shoop_3Cell.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Shoop_3Cell.h"

@implementation Shoop_3Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)remark:(id)sender {
    [self.delegate pushRemarkWithsender:sender inCell:self];
}
@end
