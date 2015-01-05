//
//  ChangePasswordViewController.m
//  Club
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "ChangePasswordService.h"

@interface ChangePasswordViewController ()
{
    ChangePasswordService *changePassword;
    UIKeyboardViewController *keyBoardController;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    self.title = @"修改登录密码";
    _oldpassword.secureTextEntry = YES;
    _newpassword.secureTextEntry =YES;
    _newpassword2.secureTextEntry =YES;
    changePassword = [[ChangePasswordService alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



- (IBAction)go:(id)sender {
    NSString *oldpassword = _oldpassword.text;
    NSString *newpassword = _newpassword.text;
    NSString *newpassword2 = _newpassword2.text;
    [changePassword changePassword:oldpassword andnewPassword:newpassword andnewpassword2:newpassword2 onChangePasswordViewcontroller:self];
    
}
@end
