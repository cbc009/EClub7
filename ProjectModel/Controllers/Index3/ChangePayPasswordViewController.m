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
    UserInfo *user;
}
@end

@implementation ChangePayPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改支付密码";
    SharedData *sharedData =[SharedData sharedInstance];
    user=sharedData.user;
    self.nickName.text=user.nickname;
    _newpassword1.secureTextEntry =YES;
    _newpassword2.secureTextEntry =YES;
    changePayPassword = [[ChangePayPasswordService alloc] init];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)save:(id)sender {
    NSString *newpassword = _newpassword1.text;
    NSString *newpassword2 = _newpassword2.text;
    [changePayPassword changePassword:self.oldPassword andnewPassword:newpassword andnewpassword2:newpassword2 onChangePayPasswordViewcontroller:self];

}
@end
