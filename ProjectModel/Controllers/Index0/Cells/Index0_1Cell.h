//
//  Index0_1Cell.h
//  Club
//
//  Created by Gao Huang on 14-12-3.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MartinLiPageScrollView.h"
@interface Index0_1Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet MartinLiPageScrollView *pageview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *pageHeight;


@end
