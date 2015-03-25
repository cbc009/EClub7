//
//  ShoopsCell.m
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "ShoopsCell.h"

@implementation ShoopsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    self.btView.layer.cornerRadius=5;
    self.btView.layer.borderWidth=1;
    [self.btView.layer setBorderColor:[SharedAction colorWithHexString:@"#dddddd"].CGColor];
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
