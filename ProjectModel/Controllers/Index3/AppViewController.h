//
//  AppViewController.h
//  Club
//
//  Created by MartinLi on 14-11-5.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guide_code.h"
@interface AppViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *QRCode;
@property(nonatomic,retain)GUIde_info *guide;
@end
