//
//  index3_3Cell.m
//  Club
//
//  Created by MartinLi on 14-11-12.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "Index3_3Cell.h"
#import "UserDetailService.h"
#import "UserDetailViewController.h"
@implementation Index3_3Cell
{
    UserDetailViewController *user;
}
- (void)awakeFromNib {
    user = [[UserDetailViewController alloc] init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)changehead:(id)sender {
   }


@end
