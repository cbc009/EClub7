//
//  KillIconCell.m
//  Club
//
//  Created by Gao Huang on 14-11-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "KillIconCell.h"

@implementation KillIconCell

- (void)awakeFromNib {
    self.dot.layer.cornerRadius=2;
 
    self.dtae.layer.cornerRadius=8;
//    self.dtae.layer.borderWidth=1;
//    self.dtae.layer.borderColor=[UIColor redColor].CGColor;
   
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
