//
//  BackGroundCell.h
//  Club
//
//  Created by MartinLi on 14-12-26.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackGroundCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *herad;
@property (weak, nonatomic) IBOutlet UIImageView *back;
@property (nonatomic,strong)  NSTimer *moveTimer;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (nonatomic,strong) NSString *imageName;

@end
