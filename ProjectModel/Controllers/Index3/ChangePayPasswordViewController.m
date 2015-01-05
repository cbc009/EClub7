//
//  ChangePayPasswordViewController.m
//  Club
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangePayPasswordViewController.h"
#import "ChangePayPasswordService.h"
@interface ChangePayPasswordViewController ()
{
    ChangePayPasswordService *changePayPassword;
    UIKeyboardViewController *keyBoardController;
}
@end

@implementation ChangePayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    keyBoardController = [[UIKeyboardViewController alloc] initWithControllerDelegate:self];
    [keyBoardController addToolbarToKeyboard];
    self.title = @"修改支付密码";
    _oldpassword.secureTextEntry = YES;
    _newpassword1.secureTextEntry =YES;
    _newpassword2.secureTextEntry =YES;
    changePayPassword = [[ChangePayPasswordService alloc] init];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)go:(id)sender {
    NSString *oldpassword = _oldpassword.text;
    NSString *newpassword = _newpassword1.text;
    NSString *newpassword2 = _newpassword2.text;
    [changePayPassword changePassword:oldpassword andnewPassword:newpassword andnewpassword2:newpassword2 onChangePayPasswordViewcontroller:self];
    
}
@end
