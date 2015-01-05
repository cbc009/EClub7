//
//  GroupDetallCell.h
//  Club
//
//  Created by MartinLi on 14-12-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GroupDetallCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *expect_num;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *actual_num;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *discount;
- (IBAction)add:(id)sender;
- (IBAction)reduce:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *number;
@end
