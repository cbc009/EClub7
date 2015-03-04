//
//  TouchIDSetViewController.h
//  Club
//
//  Created by Gao Huang on 15-3-4.
//  Copyright (c) 2015年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TouchIDAlidateViewController.h"

@interface TouchIDSetViewController : UIViewController<TouchIDSetDelegate>
@property (weak, nonatomic) IBOutlet UISwitch *switchButton;

@end
