//
//  LoginViewController.h
//  Club
//
//  Created by dongway on 14-8-10.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RegisterViewController.h"
#import "UIKeyboardViewController.h"

@protocol LoginViewControllerDelegate <NSObject>

@optional
-(void)loginSuccessedActionWithViewController:(UIViewController *)viewController;

@end

@interface LoginViewController : UIViewController<UIKeyboardViewControllerDelegate>
- (IBAction)dismissAction:(UIBarButtonItem *)sender;

@property (nonatomic,retain)id<LoginViewControllerDelegate> delegate;
@property (nonatomic,strong)NSString *loginname1;
@property (nonatomic,strong)NSString *password1;
@end
