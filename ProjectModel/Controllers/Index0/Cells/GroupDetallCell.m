//
//  GroupDetallCell.m
//  Club
//
//  Created by MartinLi on 14-12-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "GroupDetallCell.h"
#import "ItemDetailService.h"
@implementation GroupDetallCell
{
   ItemDetailService *itemDetailService;

}
- (void)awakeFromNib {
 itemDetailService = [[ItemDetailService alloc] init];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
   


    // Configure the view for the selected state
}

- (IBAction)add:(id)sender {
    self.number.text = [SharedAction addNumber:self.number];
    
}

- (IBAction)reduce:(id)sender {
    self.number.text = [SharedAction reduceNumber:self.number];

    
}
@end
