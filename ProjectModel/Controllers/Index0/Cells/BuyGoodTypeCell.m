//
//  BuyGoodTypeCell.m
//  Club
//
//  Created by Gao Huang on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "BuyGoodTypeCell.h"

@implementation BuyGoodTypeCell

- (void)awakeFromNib {
//    self.backView.layer.cornerRadius=5;
    self.backView.layer.borderWidth=1;
    [self.backView.layer setBorderColor:[SharedAction colorWithHexString:@"#dddddd"].CGColor];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
