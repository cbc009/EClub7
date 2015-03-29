//
//  Shoop_0Cell.m
//  Club
//
//  Created by MartinLi on 15-3-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "Shoop_0Cell.h"

@implementation Shoop_0Cell

- (void)awakeFromNib {
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)done:(id)sender {
    [self.delegate downWithSender:sender inCell:self];
}
@end
