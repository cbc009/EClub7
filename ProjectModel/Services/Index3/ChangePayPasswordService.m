//
//  ChangePayPasswordService.m
//  Club
//
//  Created by apple on 14-11-7.
//  Copyright (c) 2014年 martin. All rights reserved.
//

#import "ChangePayPasswordService.h"
#import "UserDefaults.h"
#import "MyMD5.h"
#import "InternetRequest.h"
#import "SharedData.h"
#import "Member_Login.h"
#import "Status.h"
#import "Club-Prefix.pch"
#import "JSONModelLib.h"

#import "SVProgressHUD.h"

@implementation ChangePayPasswordService
-(void)changePassword:(NSString *)oldpassword andnewPassword:(NSString *)newpasswd andnewpassword2:(NSString *)newpassword2 onChangePayPasswordViewcontroller:(ChangePayPasswordViewController *)ChangePayPasswordViewController
{
    BOOL ret = [newpassword2 isEqualToString:newpasswd];
    if (ret) {
        NSString *passwd1 = [MyMD5 md5:oldpassword];
        NSString *passwd2 = [MyMD5 md5:newpasswd];
        SharedData *sharedData = [SharedData sharedInstance];
        UserInfo *user = sharedData.user;
        NSString *urlString = [NSString stringWithFormat:ChangePayPassword,user.token,user.user_type,passwd2,passwd1];
        [Status getModelFromURLWithString:urlString completion:^(Status *model,JSONModelError *error){
            NSLog(@"%@",urlString);
            if (model.status==2) {
                [SVProgressHUD showSuccessWithStatus:model.error];
                [ChangePayPasswordViewController.navigationController popViewControllerAnimated:YES];
            }else {
                [SVProgressHUD showErrorWithStatus:model.error];
            }
        }];
    } else{
        [SVProgressHUD showErrorWithStatus:@"两次输入密码不相同"];
    }
    
}
@end
