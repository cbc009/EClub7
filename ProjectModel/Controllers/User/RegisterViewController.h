//
//  RegisterViewController.h
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIKeyboardViewController.h"

@interface RegisterViewController : UIViewController<UIKeyboardViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *time;
@property (weak, nonatomic) IBOutlet UIButton *checkButton;

@end
