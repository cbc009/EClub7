//
//  
//  Club
//
//  Created by dongway on 14-8-9.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RobModel.h"
#import "MartinLiPageScrollView.h"

@interface RobViewController : UIViewController<UIAlertViewDelegate,MartinLiPageScrollViewDelegate>

@property(nonatomic,retain)RobModelInfo *robModel;
@property (weak, nonatomic) IBOutlet UIButton *startTimeButton;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemPastPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *discount;
@property (weak, nonatomic) IBOutlet MartinLiPageScrollView *pageView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (copy, nonatomic ) NSString *itemPic;
@property (weak, nonatomic) IBOutlet UIButton *rob;

@end
