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
    UserInfo *user;
}
@end

@implementation ChangePasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.nickName.text=user.nickname;
    _newpassword.secureTextEntry =YES;
    _newpassword2.secureTextEntry =YES;
    changePassword = [[ChangePasswordService alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)save:(id)sender {
    NSString *newpassword = _newpassword.text;
    NSString *newpassword2 = _newpassword2.text;
    [changePassword changePassword:self.oldPassword andnewPassword:newpassword andnewpassword2:newpassword2 onChangePasswordViewcontroller:self];
}
@end
