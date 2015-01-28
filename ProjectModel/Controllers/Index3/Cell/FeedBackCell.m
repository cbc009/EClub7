//
//  FeedBackCell.m
//  Club
//
//  Created by MartinLi on 15-1-26.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "FeedBackCell.h"

@implementation FeedBackCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)goGo:(id)sender {
    [self.delegate feedbackInCell:self];
}
@end
