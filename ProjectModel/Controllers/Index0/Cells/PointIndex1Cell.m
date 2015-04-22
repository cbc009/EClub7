//
//  PointIndex1Cell.m
//  Club
//
//  Created by MartinLi on 15-4-10.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import "PointIndex1Cell.h"

@implementation PointIndex1Cell

- (void)awakeFromNib {
    self.reduceNums.layer.cornerRadius=2;
    self.reduceNums.layer.borderWidth=1;
    self.reduceNums.layer.borderColor=[UIColor redColor].CGColor;
    
    self.addnums.layer.cornerRadius=2;
    self.addnums.layer.borderWidth=1;
    self.addnums.layer.borderColor=[UIColor redColor].CGColor;
    
    self.nums.layer.cornerRadius=2;
    self.nums.layer.borderWidth=1;
    self.nums.layer.borderColor=[UIColor redColor].CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)add:(id)sender {
     self.nums.text=[SharedAction addNumber:self.nums];
}
- (IBAction)reduce:(id)sender {
    self.nums.text=[SharedAction reduceNumber:self.nums];
}
@end
