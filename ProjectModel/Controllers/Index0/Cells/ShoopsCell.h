//
//  ShoopsCell.h
//  Club
//
//  Created by MartinLi on 15-3-25.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoopsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *btView;
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *fatherName;
@property (weak, nonatomic) IBOutlet UILabel *sonName;

@end
