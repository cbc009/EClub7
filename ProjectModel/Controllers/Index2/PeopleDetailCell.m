//
//  PeopleDetailCell.m
//  Club
//
//  Created by MartinLi on 15-1-13.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PeopleDetailCell.h"
#import "MessageDetailCell.h"
#import <UIImageView+WebCache.h>
#import "LiveModel.h"
@implementation PeopleDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    self.goSomeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gotoSomeoneDetail)];
    [self.message addGestureRecognizer: self.goSomeTap];
}
-(void)gotoSomeoneDetail{
    [self.delegate requestInCell:self];
}
@end
