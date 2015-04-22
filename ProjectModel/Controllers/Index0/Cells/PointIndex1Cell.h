//
//  PointIndex1Cell.h
//  Club
//
//  Created by MartinLi on 15-4-10.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PointIndex1Cell : UITableViewCell

- (IBAction)add:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *reduceNums;
@property (weak, nonatomic) IBOutlet UILabel *nums;
- (IBAction)reduce:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *addnums;

@end
