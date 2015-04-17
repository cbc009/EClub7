//
//  SellerOrderCell.m
//  Club
//
//  Created by MartinLi on 15-4-8.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "SellerOrderCell.h"

@implementation SellerOrderCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)backGoods:(id)sender {
    [self.delegate backGoods:sender InCell:self];
}
@end
