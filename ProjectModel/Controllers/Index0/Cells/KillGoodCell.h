//
//  KillGoodCell.h
//  Club
//
//  Created by MartinLi on 14-10-22.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KillGoodCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *contDown;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet UIButton *buyNow;
@property (nonatomic,assign) NSInteger starttime;
@property (nonatomic,assign) NSInteger endtime;
@property (nonatomic,assign) NSInteger cellNums;

@end
